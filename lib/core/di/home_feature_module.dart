import 'package:get_it/get_it.dart';

import '../../features/home/presentation/cubit/focus_session_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

/// تسجيل ميزة Home (شاشة الفوكس + جلسة التركيز) — مستخرج من
/// service_locator لاحترام قاعدة 100 سطر لكل ملف.
void registerHomeFeature(GetIt sl) {
  sl.registerFactory(
    () => HomeCubit(tasksRepository: sl(), statsRepository: sl()),
  );
  sl.registerFactory(
    () => FocusSessionCubit(statsRepository: sl(), subjectsRepository: sl()),
  );
}
