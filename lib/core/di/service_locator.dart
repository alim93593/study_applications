import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' hide FirebaseService;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Features
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_use_case.dart';
import '../../features/auth/domain/usecases/get_user_profile_use_case.dart';
import '../../features/auth/domain/usecases/reset_password_use_case.dart';
import '../../features/auth/domain/usecases/sign_in_use_case.dart';
import '../../features/auth/domain/usecases/sign_out_use_case.dart';
import '../../features/auth/domain/usecases/sign_up_use_case.dart';
import '../../features/auth/domain/usecases/update_user_profile_use_case.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password_cubit.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/settings/presentation/cubit/language_cubit.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../firebase/firebase_service.dart';
import '../services/connectivity_service.dart';
import '../services/preferences_service.dart';
import '../theme/cubit/theme_cubit.dart';
import 'task_feature_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  await Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  // Register Firebase instances
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => storage);

  // Core services (Firebase facade + connectivity check)
  sl.registerLazySingleton(
    () => FirebaseService(auth: auth, firestore: firestore, storage: storage),
  );
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );

  // Unified local storage (theme / language / preferences)
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => PreferencesService(prefs));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl(), connectivity: sl()),
  );

  // Use cases
  // resetPasswordUseCase stays registered: no UI flow calls it yet, and the
  // AuthCubit method was removed as dead code until the forgot-password
  // screen lands.
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileCubit(
      getUserProfileUseCase: sl(),
      updateUserProfileUseCase: sl(),
    ),
  );
  sl.registerFactory(() => ForgotPasswordCubit(resetPasswordUseCase: sl()));

  // App-wide theme (allowed in main.dart per AGENTS — Theme exception)
  sl.registerLazySingleton(() => ThemeCubit(sl()));

  // Settings + Language (شاشات الإعدادات)
  sl.registerFactory(() => LanguageCubit(sl()));
  sl.registerFactory(() => SettingsCubit(sl()));

  // Tasks + Schedule + Stats (في ملف منفصل لاحترام قاعدة 100 سطر)
  registerTaskFeatures(sl);
}
