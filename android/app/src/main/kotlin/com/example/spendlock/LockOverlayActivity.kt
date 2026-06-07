package com.example.spendlock

import android.app.AlertDialog
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.view.WindowManager
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.activity.OnBackPressedCallback
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import java.util.Locale

class LockOverlayActivity : ComponentActivity() {
    private var remainingSeconds = 0
    private var isLimitBased = false
    private var blockedPackage: String? = null
    private var countdownHandler: Handler? = null
    private var countdownRunnable: Runnable? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        currentInstance = this
        LockOverlayManager.markActivityVisible(true)

        WindowCompat.setDecorFitsSystemWindows(window, false)
        window.statusBarColor = getColor(R.color.spendlock_white)
        window.navigationBarColor = getColor(R.color.spendlock_white)
        window.decorView.systemUiVisibility =
            View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON,
        )

        setContentView(R.layout.overlay_lock_screen)

        blockedPackage = intent.getStringExtra(EXTRA_BLOCKED_PACKAGE)
        val ruleMessage = intent.getStringExtra(EXTRA_RULE_MESSAGE).orEmpty()
        isLimitBased = intent.getBooleanExtra(EXTRA_IS_LIMIT_BASED, false)
        remainingSeconds = intent.getIntExtra(EXTRA_REMAINING_SECONDS, 0)

        val remainingView = findViewById<TextView>(R.id.lock_remaining_time)
        findViewById<TextView>(R.id.lock_rule_message).text = ruleMessage
        updateRemainingText(remainingView)
        startCountdown(remainingView)

        applyEdgeToEdgeInsets()
        setupBackPress()
        setupCoinButton()
    }

    override fun onDestroy() {
        stopCountdown()
        if (currentInstance == this) {
            currentInstance = null
        }
        LockOverlayManager.markActivityVisible(false)
        super.onDestroy()
    }

    private fun setupBackPress() {
        onBackPressedDispatcher.addCallback(
            this,
            object : OnBackPressedCallback(true) {
                override fun handleOnBackPressed() {
                    finishWithHome()
                }
            },
        )
    }

    private fun setupCoinButton() {
        findViewById<View>(R.id.lock_coin_button).setOnClickListener {
            AlertDialog.Builder(this)
                .setTitle("Use a coin?")
                .setMessage("This will override your rule once.\nYour streak stays safe.")
                .setPositiveButton("Yes, use coin") { _, _ ->
                    finishWithCoinOverride()
                }
                .setNegativeButton("Cancel", null)
                .show()
        }
    }

    private fun finishWithHome() {
        AppGuardService.resetLastBlockedPackage()
        LockOverlayManager.notifyDismissed()
        goHome()
        finish()
    }

    private fun finishWithCoinOverride() {
        val packageName = blockedPackage ?: run {
            finish()
            return
        }

        AppGuardService.grantTemporaryOverride(packageName)
        LockOverlayManager.notifyDismissed()
        openBlockedApp(packageName)
        finish()
    }

    private fun openBlockedApp(packageName: String) {
        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
        if (launchIntent == null) {
            goHome()
            return
        }
        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
        startActivity(launchIntent)
    }

    private fun goHome() {
        val homeIntent = Intent(Intent.ACTION_MAIN).apply {
            addCategory(Intent.CATEGORY_HOME)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        startActivity(homeIntent)
    }

    private fun applyEdgeToEdgeInsets() {
        val root = findViewById<View>(R.id.lock_overlay_root)
        val scrollView = findViewById<View>(R.id.lock_overlay_scroll)
        ViewCompat.setOnApplyWindowInsetsListener(root) { _, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            scrollView.setPadding(0, systemBars.top, 0, systemBars.bottom)
            insets
        }
        ViewCompat.requestApplyInsets(root)
    }

    private fun startCountdown(remainingView: TextView) {
        stopCountdown()
        if (isLimitBased) {
            remainingView.text = "Limit Active"
            return
        }

        countdownHandler = Handler(Looper.getMainLooper())
        countdownRunnable = object : Runnable {
            override fun run() {
                updateRemainingText(remainingView)
                if (remainingSeconds > 0) {
                    remainingSeconds -= 1
                    countdownHandler?.postDelayed(this, 1000L)
                }
            }
        }
        countdownHandler?.post(countdownRunnable!!)
    }

    private fun stopCountdown() {
        countdownRunnable?.let { countdownHandler?.removeCallbacks(it) }
        countdownRunnable = null
        countdownHandler = null
    }

    private fun updateRemainingText(view: TextView) {
        if (isLimitBased) {
            view.text = "Limit Active"
            return
        }

        val hours = remainingSeconds / 3600
        val minutes = (remainingSeconds % 3600) / 60
        val seconds = remainingSeconds % 60
        view.text = String.format(
            Locale.US,
            "%02d:%02d:%02d",
            hours,
            minutes,
            seconds,
        )
    }

    companion object {
        const val EXTRA_BLOCKED_PACKAGE = "blocked_package"
        const val EXTRA_RULE_MESSAGE = "rule_message"
        const val EXTRA_IS_LIMIT_BASED = "is_limit_based"
        const val EXTRA_REMAINING_SECONDS = "remaining_seconds"

        private var currentInstance: LockOverlayActivity? = null

        fun finishIfRunning() {
            currentInstance?.finish()
        }
    }
}
