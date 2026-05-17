# SpendLock

**Spend less, Grow more.** — A Flutter app for locking impulse spending, building streaks, and growing savings.

Built with the same **GetX + feature-first** architecture as [coffie-app](https://github.com/Irfanhossain909/coffie-app).

## Design

Figma: [SpendLock (Copy)](https://www.figma.com/design/8CIhvwguH61eBQtH9sKPIp/SpendLock--Copy-)

## Tech stack

- Flutter (FVM)
- GetX (routing, state, DI)
- GetStorage (local persistence)
- Google Fonts, flutter_screenutil

## Project structure

See [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md).

## Run

```bash
fvm flutter pub get
fvm flutter run
```

## App flow

1. Splash → Onboarding (3 slides) → Login / Register
2. Setup: Goal → Challenge → Notifications → Bank → Budget
3. Main tabs: Home · Rules · Tree · Streak · Profile
