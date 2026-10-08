<!--
Sync Impact Report
- Version change: (template/unversioned) → 1.0.0 — first ratification.
- Modified principles: all placeholder tokens → 6 concrete principles (I–VI).
- Added sections: Additional Constraints, Development Workflow & Quality Gates.
- Removed sections: template comments/placeholders (fully replaced).
- Templates requiring updates:
  - .specify/templates/plan-template.md ✅ updated (Constitution Check gates filled)
  - .specify/templates/tasks-template.md ✅ updated (unit tests mandatory per Principle VI)
  - .specify/templates/spec-template.md ✅ aligned (testing section already mandatory)
  - .specify/templates/commands/*.md — N/A: commands live in .github/prompts/ ✅
    validated (no stale agent-specific references found)
  - AGENTS.md / superpowers.md ✅ consistent (they are the source material and the
    runtime guidance referenced by Governance)
- Follow-up TODOs: none
-->

# Hougzaty (Study For Ever) Constitution

## Core Principles

### I. Clean Architecture, Feature-Driven (NON-NEGOTIABLE)

- Every feature MUST live under `features/<name>/` split into `data/` →
  `domain/` → `presentation/`; shared code belongs only in `core/`.
- `get_it` is the ONLY dependency source; services MUST be registered in the
  DI locator — no direct construction of services or repositories.
- Third-party libraries MUST be isolated inside `services/` or `datasources/`
  so Domain and Presentation stay framework-free.
- Naming MUST follow: `Entity`, `Model`, `Cubit`, `Page`,
  `Repository` / `RepositoryImpl`; UseCases extend
  `UseCase<Type, Params>` (use `NoParams` when empty); Entities extend
  `Equatable`.

### II. Cubit-Only State & Zero UI Logic (NON-NEGOTIABLE)

- State is managed exclusively with `flutter_bloc` **Cubits** (no raw Bloc, no
  `setState` for app state); every state uses `copyWith` + `Equatable`.
- `BlocSelector` (or `buildWhen`) MUST gate rebuilds; side effects
  (navigation / snackbar / dialog) MUST happen only in `BlocListener`.
- Cubits are provided at SCREEN level; globals in `main.dart` are limited to
  Theme, Locale, and Auth session.
- Widgets MUST NOT contain business logic: no calculations, aggregation, date
  or number formatting, complex conditions, or sequential data processing.
  The widget renders state and emits cubit events ONLY; the cubit thinks and
  decides.

### III. Stateless-Only Widgets & 100-Line Files (NON-NEGOTIABLE)

- `StatelessWidget` is the default and MUST be used whenever possible;
  `flutter_hooks` is BANNED project-wide (any usage must be removed).
- `StatefulWidget` is allowed ONLY in cases of strict necessity with no simpler
  alternative (owning a `TextEditingController`, `AnimationController`, or
  stream subscription) and MUST be justified in code comments.
- Every file and every `build` method MUST stay ≤100 lines, verified with
  `wc -l` before delivery; oversized pages are split into smaller
  `StatelessWidget`s under the feature's `widgets/` folder.

### IV. Specs Before Code (NON-NEGOTIABLE)

- Any project adopting spec-kit MUST follow the full SDD cycle:
  constitution (once) → specify → plan → tasks → implement → converge.
- No feature implementation MAY start before `specs/<NNN>-<slug>/spec.md` and
  `plan.md` exist and are approved.
- Files under `specs/` are the single source of truth; ANY deviation MUST be
  applied to the spec artifacts FIRST — silent implementation outside the
  spec is prohibited.

### V. Design System & Localization Purity (NON-NEGOTIABLE)

- Zero hardcoded strings: every string comes from `assets/translations/` via
  `.tr()` and MUST work in both Arabic (RTL) and English (LTR); image paths
  are declared only in `AppAssets`.
- Zero manual `TextStyle(...)`: typography comes from `AppTextStyles` in
  `core/theme/` (variants via `copyWith` only). Zero hardcoded colors: use
  `AppColors` ThemeExtension or `colorScheme`; Light and Dark themes MUST both
  be supported.
- Every screen MUST look correct on mobile AND desktop using
  `ResponsiveContext` (`responsiveValue`, `screenWidth`), `LayoutBuilder`, or
  `OrientationBuilder`; large fixed sizes are prohibited — use
  `Expanded`/`Flexible`/`Spacer`.

### VI. Verified Delivery (NON-NEGOTIABLE)

- Error handling is functional via `dartz` `Either<Failure, T>`; `try-catch`
  MUST NOT appear in DataSources — catching and conversion to `Failure` happen
  only in Repositories; logging uses the unified logger — `print()` is
  prohibited.
- Before any delivery: `flutter analyze` MUST report 0 issues, touched files
  MUST pass the 100-line check, and unit tests for Cubits/UseCases MUST be
  written and passing (`flutter test`).
- UI changes MUST be smoke-tested by actually running the app on a device or
  emulator; comments MUST document WHY complex code exists, not WHAT it does.
- Checks MUST NOT be weakened to pass: fix the cause; never skip tests,
  swallow errors, or add suppressions.

## Additional Constraints

- Stack: Flutter + `flutter_bloc` + `get_it` + `easy_localization` + `dartz`
  + Firebase (Auth, Firestore, Storage); fonts are bundled
  (`NotoKufiArabic`) — no runtime font downloads.
- Directory map: `core/` holds `di/`, `theme/`, `router/`, `localization/`,
  `network/`, `services/`, `utils/`, `widgets/`; features never import each
  other's internals — shared behavior moves to `core/`.
- Navigation is centralized in `AppRouter` (route constants defined there
  exactly once); data passed via `arguments` and extracted with `extractArgs`.
- Connectivity is monitored continuously; an offline state MUST be surfaced
  through a non-intrusive global banner handled by Cubits/Interceptors.

## Development Workflow & Quality Gates

- Features follow the spec-kit cycle; the plan's **Constitution Check** MUST
  pass before research/design phases proceed.
- Mandatory quality gates per feature: `flutter analyze` = 0 issues;
  `wc -l` ≤ 100 for every touched file; unit tests green for new
  Cubits/UseCases; new strings added to BOTH `ar.json` and `en.json`; runtime
  smoke test of changed screens.
- Reviews MUST verify compliance with all six principles; violations are
  fixed at the cause during the same change — deferred debt MUST be
  explicitly recorded, never silent.

## Governance

- This constitution supersedes conflicting practices. Amendments are made
  ONLY through the `/speckit.constitution` workflow with a semantic version
  bump (MAJOR: principle removal/redefinition; MINOR: new principle or
  section; PATCH: wording/clarity) and a Sync Impact Report.
- Every PR and review MUST verify compliance; added complexity MUST be
  justified against these principles.
- Runtime development guidance lives in `AGENTS.md` and `superpowers.md`;
  those files MUST stay consistent with this constitution and are the
  reference consulted during implementation.

**Version**: 1.0.0 | **Ratified**: 2026-10-03 | **Last Amended**: 2026-10-03
