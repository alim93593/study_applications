import 'package:get_it/get_it.dart';

import '../../features/shell/presentation/cubit/shell_cubit.dart';

/// تسجيل حالة الشل (التبويب النشط) — lazySingleton حي طول الجلسة
/// لأن الـ BottomNav والدرج يستدعيانه من أي مكان.
void registerShellFeature(GetIt sl) {
  sl.registerLazySingleton(() => ShellCubit());
}
