# AGENTS.md — Hougzaty (Flutter) — Project Standards & Architecture Guidelines

> **المرجع الأساسي والقانوني** لأي AI Agent أو مطوّر يعمل داخل هذا المشروع.
> هذا الملف يدمج دستور المشروع (`CONSTITUTION.md`) مع المعايير العالمية لفلاتر.
> عند التعارض بين قاعدة قديمة في الكود وهذه القواعد — الكود الجديد **يجب** أن يتبع هذا الملف.
> القاعدة الأشد هي الغالبة.

---

## 0. Spec-Kit (SDD) — أي مشروع يعتمد spec-kit

- **أي مشروع يعتمد على spec-kit يلتزم بدورة الـ SDD كاملة:** بنية `.specify/` (القوالب + `memory/constitution.md`) + أوامر `/speckit.*` (في `.github/prompts/`) + مجلد `specs/<NNN>-<slug>/` ويحوي `spec.md` ← `plan.md` ← `tasks.md`.
- **دورة كل فيتشر:** `/speckit.constitution` مرة واحدة للمشروع، ثم `specify → plan → tasks → implement → converge` — **ويُمنع البدء بالتنفيذ قبل وجود `spec.md` و `plan.md`**.
- **ملفات `specs/` هي مصدر الحقيقة:** التنفيذ يطبّق الـ spec والـ plan حرفيًا؛ أي انحراف يتطلب تعديل ملفات الـ spec أولًا — لا تنفيذ صامت خارج الـ spec.
- الأوامر تُستدعى من شات المُحرِّر المدعوم (Copilot: `/speckit.*`) أو عبر الـ Agent داخل بيئته يقرأ ملفات `.github/prompts/` ويُنفّذها بنفس المضمون.
- الـ integration الحالي مسجّل في `.specify/integration.json`؛ تغييره عبر `specify init --here --integration <key> --force`.
- **الاستدعاء داخل محرّر Freebuff (هذه البيئة):** مفيش أوامر slash مسجّلة في الواجهة — عند ورود رسالة تحتوي `speckit.<skill>` (مثل `speckit.plan`) يقرأ الـ Agent ملف `.github/prompts/speckit.<skill>.prompt.md` (+ `.github/agents/speckit.<skill>.agent.md`) وينفّذه حرفيًا بما في ذلك Pre/Post-Execution Checks والـ Sync Impact Report.

---

## 1. Architecture & State Management Rules

### A. بنية المشروع — Clean Architecture (Feature-driven)

#### `lib/core/` — القلب النابض (مشترك للمشروع كله):
- `di/` — `service_locator.dart` لحقن التبعيات عبر `get_it` (المصدر **الوحيد** للتبعيات).
- `localization/` — إعدادات اللغات وملفات الترجمة (Easy Localization).
- `router/` — نظام التنقل المركزي `AppRouter` مع تعريف الـ Routes والـ Arguments.
- `theme/` — الألوان (`AppColors`) والخطوط (`AppTextStyles`) والمسافات والـ `ThemeExtension`s.
- `services/` — الخدمات العالمية (Firebase, LocalStorage, API Client).
- `network/` — إدارة حالة الشبكة والاتصال.
- `utils/` — أدوات المساعدة، الـ Validators، والـ Extensions العامة.
- `widgets/` — المكونات البرمجية المشتركة (Custom Buttons, TextFields...).

#### `lib/features/<feature_name>/` — كل ميزة مستقلة بذاتها:
- `data/` — Models, Repositories **Implementations**, DataSources (Interfaces & Implementations).
- `domain/` — Entities, Repositories **Interfaces**, UseCases.
- `presentation/` — Cubits/States, Pages, Widgets الخاصة بالميزة.

### B. قواعد إدارة الحالة:
- **State Management:** استخدم `flutter_bloc` مع **`Cubit`** حصريًا (لا Bloc خام، لا setState لإدارة حالة التطبيق).
- **State Pattern:** كل State خاص بـ Cubit **يجب** أن يستخدم نمط **`copyWith`** (أو `freezed`) لتحديثات الحالة غير القابلة للتغيير (Immutable).
- **BlocProvider Scope:** امنح الـ Cubit دائمًا على **مستوى الشاشة** (`BlocProvider` داخل كل صفحة). **ممنوع** تسجيل Cubits خاصة بالـ UI بشكل عام في `main.dart` — الاستثناء الوحيد: الحالات العامة للتطبيق (Theme / Locale / Auth Session).
- **UI Re-rendering:** استخدم **`BlocSelector`** حصريًا (الافتراضي الإلزامي في المشروع) بحيث يعاد بناء الـ Widget **فقط** عند تغيّر الخاصية المحددة من الحالة — لا إعادة بناء لصفحة كاملة مع كل emit — **وممنوع `BlocBuilder` نهائيًا (حتى مع `buildWhen`)**.
- **Stateless Only (مُحدَّث):** استخدم `StatelessWidget` حصريًا. **ممنوع `flutter_hooks` نهائيًا** — أي استخدام موجود يُزال. ابقِ stateless ما لم يكن هناك بديل؛ و`StatefulWidget` فقط في حالة **الضرورة القصوى** (ملكية `TextEditingController` / `AnimationController` / Stream subscriptions) وبلا أي خيار أبسط.
- **Side Effects:** استخدم `BlocListener` حصريًا للـ Navigation والـ SnackBars والـ Dialogs — وليس أبدًا داخل الـ builders.
- **Zero UI Logic (قاعدة مقدسة):** ممنوع منعًا باتًا كتابة أي منطق (Logic) داخل الـ UI — لا حسابات، لا تجميع (reduce/fold)، لا تحقق شرطي معقد، لا تنسيق تواريخ/أرقام، لا `if` لوجيكي للأعمال، ولا استدعاءات متسلسلة لمعالجة بيانات داخل الـ Widgets. كل منطق الأعمال والرسائل والحالات يُنفَّذ في **الـ Cubit** (أو UseCase للمنطق المعقد)، والـ Widget **يعرض الحالة فقط ويستدعي أحداث الـ Cubit**. القاعدة: "الـ UI يعرض ويُصدّر الأحداث فقط — الـ Cubit يفكر وقرر".

---

## 2. File & Widget Structure Rules

- **100-Line Limit Rule:** لا يجوز أن يتجاوز أي ملف أو أي دالة `build` **100 سطر**.
- **Widget Modularization:** إذا زادت الشاشة عن الحد، استخرج المكونات إلى ملفات `StatelessWidget` أصغر داخل مجلد `widgets/` الخاص بالـ feature (وليس داخل مجلد `screens/`). تبقى الـ Pages **رفيعة (Thin Pages)**: تركيب فقط — الـ Cubit/State + الاستيراد من الـ Widgets.
- **تنبيه صارم**: القاعدة تنطبق على **كل ملف** — Pages و Widgets و Cubits — ليس الصفحات فقط. الـ Cubit المعقد يُقسّم إلى Methods واضحة أو Helpers، والـ Widget الكبير يُقسّم إلى Widgets أصغر. لا استثناءات لأي ملف في المشروع.
- **فحص الحجم:** عند كتابة أو تعديل أي صفحة، تحقق أولًا من `wc -l` — إذا تجاوز 100 سطر ابدأ التقسيم فورًا قبل إكمال العمل.
- **Reusable Components:** أعطِ أولوية للمكونات المشتركة العامة (CustomButton, CustomTextField...) من `lib/core/widgets/`.

---

## 3. Domain Layer Standards

- **Base UseCase:** توحيد منطق العمل — كل UseCase يرث الكلاس الأب الموحد:
  ```dart
  abstract class UseCase<Type, Params> {
    Future<Either<Failure, Type>> call(Params params);
  }
  ```
- **NoParams:** عند عدم وجود باراميترات استخدم كلاس `NoParams` — لا `void` ولا `null`.
- **Entities:** كائنات Dart صافية (Plain Objects) تمثل البيانات الأساسية، وترث من `Equatable`.

---

## 4. Strings, Assets & Localization

- **Zero Hardcoded Strings:** ممنوع كتابة نصوص مباشرة؛ كل النصوص عبر `assets/translations/` والوصول بـ `.tr()`.
- **Localization:** دعم RTL (العربية) و LTR (الإنجليزية) بسلاسة باستخدام **Easy Localization** (معيار المشروع).
- **Asset Management:** ممنوع كتابة مسارات الصور يدويًا؛ كل المسارات تُعرَّف في `AppAssets` داخل الـ `core`.

---

## 5. Theming & Design System

- **Theming:** إدارة الثيم الكاملة (Light/Dark) عبر `ThemeData`. ممنوع الألوان المكتوبة يدويًا (Hardcoded)؛ استخدم الثيم (`context.colors.*` و `Theme.of(context).colorScheme` حيث ينطبق).
- **الألوان:** تعريف `AppColors` كـ `ThemeExtension` لدعم الـ Light والـ Dark: `context.colors.primary`.
- **الخطوط (Typography):** كل ستايلات النصوص معرّفة في كلاس `AppTextStyles` داخل `core/theme/` — **ممنوع كتابة `TextStyle(...)` يدويًا داخل أي Widget**؛ الوصول عبر `AppTextStyles.titleLarge` مثلاً، والمشتقات عبر `copyWith` فقط.

---

## 6. Navigation & Auth / Splash Handling

- **النظام:** المركزية الكاملة عبر `AppRouter`.
- **Named Routes:** استخدام الثوابت (Constants) فقط لتعريف الـ Routes.
- **Arguments:** تمرير البيانات عبر `arguments` واستخراجها داخل الـ `AppRouter` باستخدام `extractArgs`.
- **Splash Screen Flow:**
  1. فحص التخزين المحلي (`flutter_secure_storage`) عن Auth Token صالح.
  2. إذا كان التوكن موجودًا وصالحًا → التوجيه إلى `HomeScreen`.
  3. إذا لم يكن موجودًا أو غير صالح → التوجيه إلى `LoginScreen`.

---

## 7. استراتيجية التجاوب (Responsiveness Strategy)

- **القاعدة:** الاعتماد على **Built-in Responsiveness** عبر `ResponsiveContext` Extension (بدون باكدجات ثقيلة).
- **الأدوات الإلزامية:**
  - استخدام `context.screenWidth` و `context.screenHeight` للحسابات النسبية.
  - استخدام `context.responsiveValue<T>(mobile: ..., tablet: ..., desktop: ...)` لتغيير القيم بناءً على حجم الشاشة.
  - استخدام `LayoutBuilder` و `OrientationBuilder` للمكونات التي تتأثر بمساحة الحاوية وليس فقط الشاشة.
- **قواعد القياس:** ممنوع استخدام قيم ثابتة ضخمة (Fixed Width/Height)؛ استخدم `Expanded` و `Flexible` و `Spacer` لضمان مرونة التصميم. **كل صفحة يجب أن تبدو صحيحة على الموبايل والديسكتوب معًا.**

---

## 8. معالجة الأخطاء (Error Handling)

- **الأسلوب:** Functional Error Handling باستخدام مكتبة `dartz` (`Either<Failure, T>`).
- **القاعدة (جديدة): ممنوع منعًا باتًا استخدام `try-catch` داخل طبقة الـ DataSources** — الـ DataSource يرفع الخطأ كما هو دون أي التقاط.
- **الالتقاط والتحويل إلى `Either<Failure, T>` يتم حصريًا في طبقة Repositories** — وهي الطبقة الوحيدة التي تكتب `try-catch`.
- الـ Cubits/UseCases/الواجهات لا تكتب `try-catch` إطلاقًا.

---

## 9. Network Connectivity Handling

- مراقبة اتصال الإنترنت **بشكل مستمر** باستخدام `connectivity_plus` أو `internet_connection_checker`.
- عرض **بانر عالمي غير مُقحِم (Non-intrusive)** أو معالجة حالات عدم الاتصال تلقائيًا عبر كل الـ Features باستخدام Cubit/Interceptors مخصصة.

---

## 10. القواعد العامة للكود (Coding Standards)

- **Logging:** يمنع استخدام `print()` — استخدم الـ `logger` الموحد.
- **Third-party Isolation:** تغليف المكتبات الخارجية داخل `services/` أو `datasources/` لضمان استقلالية طبقات الـ Domain والـ Presentation.
- **Local Storage:** التعامل مع `SharedPreferences` أو أي تخزين محلي يكون عبر كلاس خدمي موحد (e.g. `PreferencesService`) مسجَّل في الـ DI.
- **Firestore Paths:** ممنوع كتابة مسارات collections/documents كنصوص مباشرة (Hardcoded Strings) — كل المسارات عبر ثوابت `FirestorePaths` في `core/firebase/`.
- **DI:** `get_it` هو المصدر الوحيد للتبعيات.

---

## 11. اتفاقية التسمية (Naming Convention)

| العنصر | اللاحقة |
|---|---|
| Entities | `Entity` |
| Models | `Model` |
| Cubits | `Cubit` |
| Pages | `Page` |
| Repositories (Interface / Implementation) | `Repository` / `RepositoryImpl` |

---

## 12. الجودة والتوثيق (Quality Assurance)

- **Testing:** الالتزام بـ Unit Tests لمنطق العمل (Cubits / UseCases).
- **Comments:** توثيق "سبب" (Why) كتابة الكود المعقد وليس فقط "ماذا" يفعل.

---

**تذكّر:** "الكود النظيف ليس كودًا يعمل فحسب، بل هو كود يحكي قصة المشروع بوضوح."
