import UIKit

struct LockOverlayPayload {
    let ruleMessage: String
    let isLimitBased: Bool
    let remainingSeconds: Int

    static func from(arguments: Any?) -> LockOverlayPayload? {
        guard let map = arguments as? [String: Any] else { return nil }
        return LockOverlayPayload(
            ruleMessage: map["ruleMessage"] as? String ?? "Your rule is currently active",
            isLimitBased: map["isLimitBased"] as? Bool ?? false,
            remainingSeconds: map["remainingSeconds"] as? Int ?? 0
        )
    }

    static func `default`(packageName: String) -> LockOverlayPayload {
        LockOverlayPayload(
            ruleMessage: "This app is blocked by SpendLock",
            isLimitBased: false,
            remainingSeconds: 0
        )
    }
}

private enum SpendLockColors {
    static let primary = UIColor(red: 0.055, green: 0.510, blue: 0.475, alpha: 1)
    static let black = UIColor(red: 0.016, green: 0.110, blue: 0.216, alpha: 1)
    static let gray = UIColor(red: 0.420, green: 0.482, blue: 0.584, alpha: 1)
    static let lightGray = UIColor(red: 0.706, green: 0.745, blue: 0.808, alpha: 1)
    static let coinGold = UIColor(red: 1.0, green: 0.722, blue: 0.0, alpha: 1)
    static let stroke = UIColor(red: 0.106, green: 0.212, blue: 0.384, alpha: 0.1)
    static let primaryTint = UIColor(red: 0.055, green: 0.510, blue: 0.475, alpha: 0.1)
    static let coinBg = UIColor(red: 1.0, green: 0.722, blue: 0.0, alpha: 0.1)
}

final class LockOverlayViewController: UIViewController {
    private let payload: LockOverlayPayload
    private let blockedPackage: String
    private var remainingSeconds: Int
    private var countdownTimer: Timer?

    private let remainingLabel = UILabel()
    private let messageLabel = UILabel()

    init(payload: LockOverlayPayload, blockedPackage: String) {
        self.payload = payload
        self.blockedPackage = blockedPackage
        self.remainingSeconds = payload.remainingSeconds
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        startCountdown()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override var prefersStatusBarHidden: Bool {
        false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }

    override var canBecomeFirstResponder: Bool {
        true
    }

    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.keyCode == .keyboardEscape {
                LockOverlayManager.shared.handleBackPress()
                return
            }
        }
        super.pressesEnded(presses, with: event)
    }

    private func setupLayout() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)

        let content = UIStackView()
        content.axis = .vertical
        content.alignment = .center
        content.spacing = 16
        content.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(content)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            content.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 16
            ),
            content.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 16
            ),
            content.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -16
            ),
            content.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -16
            ),
            content.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -32
            ),
        ])

        applySafeAreaInsets(to: scrollView)

        let logo = UIImageView(image: UIImage(named: "spendlock_logo"))
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.widthAnchor.constraint(equalToConstant: 123).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 123).isActive = true
        content.addArrangedSubview(logo)

        content.addArrangedSubview(makeLabel("SpendLock", size: 24, weight: .bold))
        content.addArrangedSubview(makeLabel("Hold On!", size: 32, weight: .heavy))

        messageLabel.text = payload.ruleMessage
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = SpendLockColors.gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        content.addArrangedSubview(messageLabel)

        let timerCard = makeCardStack(
            title: "Time Remaining",
            valueLabel: remainingLabel,
            valueSize: 42
        )
        content.addArrangedSubview(timerCard)
        timerCard.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true

        let tipView = makeTipView()
        content.addArrangedSubview(tipView)
        tipView.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true

        let coinButton = makeCoinButton()
        content.addArrangedSubview(coinButton)
        coinButton.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true

        let streakLabel = makeLabel(
            "Skipping will break your 12-day streak",
            size: 16,
            weight: .regular,
            color: SpendLockColors.lightGray
        )
        content.addArrangedSubview(streakLabel)

        updateRemainingText()
    }

    private func applySafeAreaInsets(to scrollView: UIScrollView) {
        let insets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(
            top: insets.top,
            left: 0,
            bottom: insets.bottom,
            right: 0
        )
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            applySafeAreaInsets(to: scrollView)
        }
    }

    private func makeLabel(
        _ text: String,
        size: CGFloat,
        weight: UIFont.Weight,
        color: UIColor = SpendLockColors.black
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private func makeCardStack(title: String, valueLabel: UILabel, valueSize: CGFloat) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 1
        container.layer.borderColor = SpendLockColors.stroke.cgColor
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.04
        container.layer.shadowRadius = 12
        container.layer.shadowOffset = CGSize(width: 0, height: 4)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)

        let titleLabel = makeLabel(title, size: 12, weight: .medium)
        valueLabel.font = .systemFont(ofSize: valueSize, weight: .medium)
        valueLabel.textColor = SpendLockColors.black
        valueLabel.textAlignment = .center

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24),
        ])

        return container
    }

    private func makeTipView() -> UIView {
        let container = UIView()
        container.backgroundColor = SpendLockColors.primaryTint
        container.layer.cornerRadius = 12

        let border = UIView()
        border.backgroundColor = SpendLockColors.primary
        border.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(border)

        let icon = UILabel()
        icon.text = "💡"
        icon.font = .systemFont(ofSize: 14)
        icon.textAlignment = .center
        icon.backgroundColor = SpendLockColors.coinBg
        icon.layer.cornerRadius = 14
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false

        let text = UILabel()
        text.text = "Are you really hungry, or just bored? Try drinking water and waiting 15 minutes"
        text.font = .systemFont(ofSize: 12)
        text.textColor = SpendLockColors.black
        text.numberOfLines = 2
        text.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(icon)
        container.addSubview(text)

        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            border.topAnchor.constraint(equalTo: container.topAnchor),
            border.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            border.widthAnchor.constraint(equalToConstant: 3),

            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18),
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.heightAnchor.constraint(equalToConstant: 28),

            text.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            text.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18),
            text.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            text.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])

        return container
    }

    private func makeCoinButton() -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 1
        container.layer.borderColor = SpendLockColors.stroke.cgColor
        container.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCoinTap))
        container.addGestureRecognizer(tap)

        let icon = UILabel()
        icon.text = "🪙"
        icon.font = .systemFont(ofSize: 14)
        icon.textAlignment = .center
        icon.backgroundColor = SpendLockColors.coinBg
        icon.layer.cornerRadius = 14
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false

        let text = UILabel()
        text.text = "Use Coin to Override (12 left)"
        text.font = .systemFont(ofSize: 12)
        text.textColor = SpendLockColors.coinGold
        text.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(icon)
        container.addSubview(text)

        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -110),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.heightAnchor.constraint(equalToConstant: 28),

            text.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),

            container.heightAnchor.constraint(equalToConstant: 56),
        ])

        return container
    }

    @objc private func handleCoinTap() {
        let alert = UIAlertController(
            title: "Use a coin?",
            message: "This will override your rule once.\nYour streak stays safe.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Yes, use coin", style: .default) { _ in
            LockOverlayManager.shared.dismissWithCoinOverride()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countdownTimer?.invalidate()
    }

    private func startCountdown() {
        if payload.isLimitBased {
            remainingLabel.text = "Limit Active"
            return
        }

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            }
            self.updateRemainingText()
        }
    }

    private func updateRemainingText() {
        if payload.isLimitBased {
            remainingLabel.text = "Limit Active"
            return
        }

        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        remainingLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

final class LockOverlayManager {
    static let shared = LockOverlayManager()

    private var overlayWindow: UIWindow?
    private var blockedPackage: String?
    private var storedPayloads: [String: LockOverlayPayload] = [:]

    var onDismiss: (() -> Void)?

    private init() {}

    func isShowing() -> Bool {
        overlayWindow != nil
    }

    func savePayloads(_ rawPayloads: [String: Any]) {
        var payloads: [String: LockOverlayPayload] = [:]
        rawPayloads.forEach { key, value in
            guard let map = value as? [String: Any] else { return }
            payloads[key] = LockOverlayPayload.from(arguments: map)
        }
        storedPayloads = payloads
    }

    func show(blockedPackage: String, payload: LockOverlayPayload?) {
        if overlayWindow != nil { return }

        let resolvedPayload = payload
            ?? storedPayloads[blockedPackage]
            ?? LockOverlayPayload.default(packageName: blockedPackage)

        self.blockedPackage = blockedPackage

        let controller = LockOverlayViewController(
            payload: resolvedPayload,
            blockedPackage: blockedPackage
        )

        let window: UIWindow
        if let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }) {
            window = UIWindow(windowScene: scene)
            window.frame = scene.screen.bounds
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }

        window.windowLevel = .alert + 1
        window.rootViewController = controller
        window.backgroundColor = .white
        window.isOpaque = true
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()

        overlayWindow = window
    }

    func hide() {
        overlayWindow?.isHidden = true
        overlayWindow = nil
        blockedPackage = nil
    }

    func handleBackPress() {
        dismiss(sendHome: true)
    }

    func dismissWithCoinOverride() {
        hide()
        onDismiss?()
    }

    func dismiss(sendHome: Bool) {
        hide()
        onDismiss?()
    }
}