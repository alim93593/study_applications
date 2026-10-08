import 'package:get_it/get_it.dart';

import '../../features/schedule/data/datasources/schedule_remote_data_source.dart';
import '../../features/schedule/data/repositories/schedule_repository_impl.dart';
import '../../features/schedule/domain/repositories/schedule_repository.dart';
import '../../features/schedule/presentation/cubit/schedule_cubit.dart';
import '../../features/stats/data/datasources/stats_remote_data_source.dart';
import '../../features/stats/data/repositories/stats_repository_impl.dart';
import '../../features/stats/domain/repositories/stats_repository.dart';
import '../../features/stats/presentation/cubit/stats_cubit.dart';
import '../../features/tasks/data/datasources/subjects_remote_data_source.dart';
import '../../features/tasks/data/datasources/tasks_remote_data_source.dart';
import '../../features/tasks/data/repositories/subjects_repository_impl.dart';
import '../../features/tasks/data/repositories/tasks_repository_impl.dart';
import '../../features/tasks/domain/repositories/subjects_repository.dart';
import '../../features/tasks/domain/repositories/tasks_repository.dart';
import '../../features/tasks/presentation/cubit/new_task_cubit.dart';
import '../../features/tasks/presentation/cubit/tasks_cubit.dart';

/// تسجيل عائلة المهام/الجدول/الإحصائيات — مستخرج من service_locator
/// لاحترام قاعدة 100 سطر لكل ملف.
void registerTaskFeatures(GetIt sl) {
  // Tasks
  sl.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(firebase: sl()),
  );
  sl.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(dataSource: sl(), connectivity: sl()),
  );
  sl.registerLazySingleton<SubjectsRemoteDataSource>(
    () => SubjectsRemoteDataSourceImpl(firebase: sl()),
  );
  sl.registerLazySingleton<SubjectsRepository>(
    () => SubjectsRepositoryImpl(
      dataSource: sl(),
      connectivity: sl(),
      prefs: sl(),
    ),
  );
  sl.registerFactory(() => TasksCubit(repository: sl()));
  sl.registerFactory(
    () => NewTaskCubit(repository: sl(), subjectsRepository: sl()),
  );

  // Schedule
  sl.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(firebase: sl()),
  );
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(dataSource: sl(), connectivity: sl()),
  );
  sl.registerFactory(() => ScheduleCubit(repository: sl()));

  // Stats
  sl.registerLazySingleton<StatsRemoteDataSource>(
    () => StatsRemoteDataSourceImpl(firebase: sl()),
  );
  sl.registerLazySingleton<StatsRepository>(
    () => StatsRepositoryImpl(dataSource: sl(), connectivity: sl()),
  );
  sl.registerFactory(
    () => StatsCubit(statsRepository: sl(), tasksRepository: sl()),
  );
}
