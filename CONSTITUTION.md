# دستور تطوير تطبيقات فلاتر (Flutter Project Constitution)

هذا المستند هو المرجع الأساسي والقانوني لأي مشروع يتم تطويره، لضمان الكفاءة، السرعة، وقابلية التوسع.

---

## 1. بنية المشروع (Architecture)
- **النظام المتبع**: Clean Architecture (Feature-driven).
- **هيكل المجلدات الإلزامي**:

### A. مجلد الـ `core/` (القلب النابض):
يحتوي على الأجزاء المشتركة التي تخدم المشروع بالكامل:
- `di/`: يحتوي على `service_locator.dart` لحقن التبعيات عبر `get_it`.
- `localization/`: إعدادات اللغات وملفات الترجمة (Easy Localization).
- `router/`: نظام التنقل المركزي `AppRouter` مع تعريف الـ Routes والـ Arguments.
- `theme/`: الألوان (`AppColors`) والخطوط (`AppTextStyles`) والمسافات والـ `ThemeExtensions`.
- `services/`: الخدمات العالمية (Firebase, LocalStorage, API Client).
- `network/`: إدارة حالة الشبكة والاتصال.
- `utils/`: أدوات المساعدة، الـ Validators، والـ Extensions العامة.
- `widgets/`: المكونات البرمجية المشتركة (Custom Buttons, TextFields).

### B. مجلد الـ `features/` (المميزات):
كل ميزة مستقلة بذاتها وتتبع التقسيم التالي:
- `feature_name/`
    - `data/`: تشمل (Models, Repositories Implementation, DataSources Interfaces & Implementations).
    - `domain/`: تشمل (Entities, Repositories Interfaces, UseCases).
    - `presentation/`: تشمل (Cubits/States, Pages, Widgets الخاصة بالميزة).

---

## 2. معايير طبقة الـ Domain (Domain Layer Standards)
- **Base UseCase**: لتوحيد التعامل مع منطق العمل، يجب أن ترث جميع الـ UseCases من كلاس أب موحد:
    ```dart
    abstract class UseCase<Type, Params> {
      Future<Either<Failure, T>> call(Params params);
    }
    ```
- **NoParams**: في حالة عدم وجود باراميترات، يتم استخدام كلاس `NoParams` بدلاً من `void` أو `null`.
- **Entities**: هي كائنات Dart صافية (Plain Objects) تمثل البيانات الأساسية، ويجب أن ترث من `Equatable`.

---

## 3. إدارة النصوص والأصول (Assets & Strings)
- **Zero Hardcoded Strings**: ممنوع كتابة نصوص مباشرة؛ كل شيء عبر `assets/translations/` والوصول بـ `.tr()`.
- **Asset Management**: ممنوع كتابة مسارات الصور يدوياً؛ كل المسارات تُعرف في `AppAssets` داخل الـ `core`.

---

## 4. استراتيجية الثيم والخطوط (Design System)
- **الخطوط (Typography)**: الاعتماد على `google_fonts` وتعريفها كـ `ThemeExtension` لسلاسة الوصول: `context.textStyles.bodyLarge`.
- **الألوان (Colors)**: تعريف `AppColors` كـ `ThemeExtension` لدعم الـ Light والـ Dark Mode: `context.colors.primary`.

---

## 5. إدارة الحالة والأداء (State & Performance)
- **السياسة**: **Stateless Only** باستخدام `flutter_hooks` لإدارة دورة حياة.
- **BlocSelector**: هو الخيار الإلزامي لبناء الواجهات لضمان عدم إعادة بناء الـ Widget إلا عند تغير البيانات المحددة بدقة.
- **Side Effects**: استخدام `BlocListener` حصراً للـ Navigation والـ SnackBars والـ Dialogs.

---

## 6. التوجيه وتمرير البيانات (Named Routing)
- **النظام**: المركزية الكاملة عبر `AppRouter`.
- **Named Routes**: استخدام الثوابت (Constants) فقط لتعريف الـ Routes.
- **Arguments**: تمرير البيانات عبر `arguments` واستخراجها داخل الـ `AppRouter` باستخدام `extractArgs`.

---

## 7. استراتيجية التجاوب (Responsiveness Strategy)
- **القاعدة**: الاعتماد على **Built-in Responsiveness** عبر `ResponsiveContext` Extension (بدون باكدجات ثقيلة).
- **الأدوات الإلزامية**:
    - استخدام `context.screenWidth` و `context.screenHeight` للحسابات النسبية.
    - استخدام `context.responsiveValue<T>(mobile: ..., tablet: ..., desktop: ...)` لتغيير القيم بناءً على حجم الشاشة.
    - استخدام `LayoutBuilder` و `OrientationBuilder` للقطع (Components) التي تتأثر بمساحة الحاوية وليس فقط الشاشة.
- **قواعد القياس**: ممنوع استخدام قيم ثابتة ضخمة (Fixed Width/Height)؛ يجب استخدام `Expanded`, `Flexible`, و `Spacer` لضمان مرونة التصميم.

---

## 8. معالجة الأخطاء (Error Handling)
- **الأسلوب**: Functional Error Handling باستخدام مكتبة `dartz` (`Either<Failure, T>`).
- **القاعدة**: حصر الـ `try-catch` في طبقة الـ `DataSources` فقط.

---

## 9. القواعد العامة للكود (Coding Standards)
- **Logging**: يمنع استخدام `print()؛ يجب استخدام الـ `logger` الموحد.
- **Third-party Isolation**: تغليف المكتبات الخارجية في `services` أو `datasources` لضمان استقلالية طبقات الـ `Domain` و الـ `Presentation`.
- **Local Storage**: التعامل مع `SharedPreferences` أو أي تخزين محلي يكون عبر كلاس خدمي موحد (e.g. `PreferencesService`) مسجل في الـ DI.
- **DI**: `get_it` هو المصدر الوحيد للتبعيات.

---

## 10. اتفاقية التسمية (Naming Convention)
- **Entities**: تنتهي بـ `Entity`.
- **Models**: تنتهي بـ `Model`.
- **Cubits**: تنتهي بـ `Cubit`.
- **Pages**: تنتهي بـ `Page`.
- **Repositories**: تنتهي بـ `Repository` للـ Interfaces و `RepositoryImpl` للـ Implementation.

---

## 11. الجودة والتوثيق (Quality Assurance)
- **Testing**: الالتزام بـ `Unit Tests` للمنطق البرمجي (Cubits/UseCases).
- **Comments**: توثيق "سبب" (Why) كتابة الكود المعقد وليس فقط "ماذا" يفعل.

---
**تذكر**: "الكود النظيف ليس كوداً يعمل فحسب، بل هو كود يحكي قصة المشروع بوضوح."
