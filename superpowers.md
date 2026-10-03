# SUPERPOWERS.md — Hougzaty (Flutter) — Core Powers & Operating Rules

> **المرجع المختصر والمُلزِم** لسلوك الـ Agent داخل هذا المشروع.
> النسخة الكاملة للقواعد في `AGENTS.md` (المدموج من `CONSTITUTION.md`).
> هذا الملف هو "القوى العظمى": ما **يجب** و ما **يجب ألا** يفعله الـ Agent دائمًا.

---

## 🏗️ Architecture Powers

- **Clean Architecture Feature-driven** إلزامية: `data/` → `domain/` → `presentation/` داخل كل feature.
- **Cubit only** مع `flutter_bloc` — لا Bloc خام، لا setState لإدارة الحالة.
- **🚫 ممنوع `flutter_hooks` نهائيًا** — استخدم `StatelessWidget` أولاً؛ و`StatefulWidget` فقط في حالة الضرورة القصوى (ملكية Controllers/Animation/Streams) وبلا بديل أبسط.
- كل State يستخدم **`copyWith`** (أو `freezed`) — الحالة Immutable دائمًا.
- **`BlocProvider` على مستوى الشاشة** — لا Cubits عالمية في `main.dart` إلا لحالات التطبيق العامة (Theme/Locale/Auth).
- **`BlocSelector`** هو الأداة الإلزامية للبناء — الـ Widget لا يُعاد بناؤه إلا عند تغيّر البيانات المحددة (بديل مقبول: `buildWhen`).
- **Side Effects** (Navigation / SnackBar / Dialog) حصرًا عبر `BlocListener`.
- **🚫 ZERO UI LOGIC — قاعدة مقدسة:** ممنوع أي منطق في الـ UI إطلاقًا — لا حسابات، لا تجميع، لا تحقق شرطي للأعمال، لا تنسيق تواريخ/أرقام داخل أي Widget. الـ Widget **يعرض الحالة ويُصدّر الأحداث فقط** — كل التفكير في الـ Cubit (والمنطق المعقد في UseCases). مثال: بدل `Text('${expenses.fold(0, (s,e) => s+e.amount)}')` → الحالة فيها `total` جاهز من الـ Cubit.
- **كل ملف ≤ 100 سطر بلا استثناء** — يشمل Pages و Widgets و Cubits، ويُقاس بـ `wc -l` قبل التسليم.
- **📦 Spec-Kit إلزامي في أي مشروع يعتمد spec-kit:** لا تنفيذ لأي فيتشر بدون `specs/<NNN>-<slug>/spec.md` و`plan.md`؛ الدورة: `constitution` (once) → `specify` → `plan` → `tasks` → `implement` → `converge`، والتنفيذ يطبّق ملفات الـ spec حرفيًا.

## 📏 File Structure Powers

- **قاعدة الـ 100 سطر مقدسة**: أي ملف أو دالة `build` تتجاوز 100 سطر **يجب** تقسيمها فورًا.
- المكونات المستخرجة تُوضع في `widgets/` الخاص بالـ feature — والصفحة تبقى رفيعة (Thin Page) تركّب فقط.
- تحقق بـ `wc -l` قبل ما تكمل أي تعديل على صفحة.
- الأولوية دائمًا للمكونات المشتركة من `lib/core/widgets/`.

## 🌍 Strings & Localization Powers

- **Zero Hardcoded Strings** — كل نص عبر `assets/translations/` + `.tr()` (Easy Localization).
- دعم **RTL (عربي) + LTR (إنجليزي)** في كل شاشة جديدة.
- مسارات الصور عبر `AppAssets` فقط — لا مسارات يدوية.

## 🎨 Theming Powers

- لا ألوان Hardcoded إطلاقًا — استخدم `context.colors.*` (ThemeExtension) أو `colorScheme`.
- **🚫 ممنوع `TextStyle(...)` يدوي في أي Widget** — كل الستايلات من `AppTextStyles` في `core/theme/` (والمشتقات عبر `copyWith`).
- Light/Dark mode مدعومان دائمًا.

## 🧭 Navigation Powers

- التنقل مركزي بالكامل عبر `AppRouter` — Named Routes بالثوابت فقط.
- تمرير البيانات عبر `arguments` واستخراجها بـ `extractArgs` داخل الـ Router.
- **Splash Flow**: Token موجود وصالح → `HomeScreen` | Token مفقود/غير صالح → `LoginScreen` (فحص من التخزين الآمن).

## 📱 Responsiveness Powers

- **كل شاشة ريسبونسف على الموبايل والويب/الديسكتوب معًا** — ده شرط إطلاق مش رفاهية.
- استخدم `context.screenWidth` / `context.responsiveValue<T>(...)` و `LayoutBuilder`.
- ممنوع المقاسات الثابتة الضخمة — `Expanded` / `Flexible` / `Spacer`.

## 🌐 Network Powers

- مراقبة الاتصال مستمرة (`connectivity_plus` / `internet_connection_checker`).
- بانر عالمي غير مُقحِم عند انقطاع النت — معالجة أوتوماتيكية عبر Cubits/Interceptors.

## ⚙️ Coding Powers

- **Functional Error Handling** بـ `dartz` (`Either<Failure, T>`).
- `try-catch` في **DataSources فقط**.
- لا `print()` — الـ logger الموحد فقط.
- المكتبات الخارجية معزولة داخل `services/` أو `datasources/`.
- التخزين المحلي عبر `PreferencesService` المسجَّلة في الـ DI — لا وصول مباشر.
- **`get_it` هو المصدر الوحيد للتبعيات** — لا `new` مباشر للخدمات.
- UseCases ترث `UseCase<Type, Params>` الموحد — و `NoParams` عند عدم وجود باراميترات.
- Entities كائنات صافية ترث `Equatable`.

## ✅ Quality Powers

- Unit Tests إلزامية للـ Cubits والـ UseCases.
- التعليقات توثّق **السبب (Why)** لا الوصف (What).
- قبل تسليم أي شغل: `flutter analyze` صفر أخطاء.

---

## ⚡ Quick Rules (فتح باب سريع)

1. صفحة جديدة؟ → Thin Page + Cubit على مستوى الشاشة + Widgets منفصلة.
2. ملف > 100 سطر؟ → قسّمه فورًا (أي ملف — لا استثناءات).
3. نص جديد؟ → translations + `.tr()`.
4. لون جديد؟ → ThemeExtension.
5. State جديد؟ → `copyWith` + Equatable.
6. إعادة بناء UI؟ → `BlocSelector`.
7. Navigation؟ → `AppRouter` + constants.
8. بيانات من خارج الـ App؟ → DataSource + Repository + UseCase.
9. خطأ محتمل؟ → `Either<Failure, T>`.
10. لوجيك في الـ UI؟ → **ممنوع** — انقله للـ Cubit فورًا.
11. خلصت تعديل؟ → `flutter analyze` + `wc -l` + اختبر.
12. ستايل نص جديد؟ → `AppTextStyles` في core — لا TextStyle يدوي.
13. محتاج hooks؟ → **ممنوع** — stateless أو Stateful للضرورة القصوى فقط.
14. مشروع spec-kit؟ → التزم بـ `specs/` (spec → plan → tasks) قبل أي تنفيذ.
15. رسالة فيها `speckit.<skill>`؟ → اقرأ `.github/prompts/speckit.<skill>.prompt.md` وأنفّذه حرفيًا (هنا في Freebuff مفيش slash UI).

---

**تذكّر:** "الكود النظيف ليس كودًا يعمل فحسب، بل هو كود يحكي قصة المشروع بوضوح."
