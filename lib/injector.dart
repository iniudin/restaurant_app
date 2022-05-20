import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/data/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/service/database_service.dart';
import 'package:restaurant_app/data/service/notification_service.dart';
import 'package:restaurant_app/data/service/shared_preference_service.dart';
import 'package:restaurant_app/data/source/local_data_source.dart';
import 'package:restaurant_app/data/source/remote_data_source.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecase/detail.dart';
import 'package:restaurant_app/domain/usecase/favorite.dart';
import 'package:restaurant_app/domain/usecase/home.dart';
import 'package:restaurant_app/domain/usecase/search.dart';
import 'package:restaurant_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_index_cubit.dart';
import 'package:restaurant_app/presentation/bloc/search/search_bloc.dart';
import 'package:restaurant_app/presentation/bloc/setting/notification_cubit.dart';
import 'package:restaurant_app/utils/datetime/datetime_helper.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  DateTimeHelper.initTimezone();
  NotificationService().initialize();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await AndroidAlarmManager.initialize();
  }

  /// Initialize for BLoC
  getIt.registerFactory<HomeIndexCubit>(
    () => HomeIndexCubit(),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      usecase: getIt(),
    ),
  );
  getIt.registerFactory<DetailBloc>(
    () => DetailBloc(
      usecase: getIt(),
    ),
  );
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(
      usecase: getIt(),
    ),
  );
  getIt.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(
      usecase: getIt(),
    ),
  );

  getIt.registerFactory<NotificationCubit>(
    () => NotificationCubit(
      notificationService: getIt(),
      preferenceService: getIt(),
    ),
  );

  /// Initialize for Services
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
  getIt.registerLazySingleton<DatabaseService>(
    () => DatabaseService(),
  );

  getIt.registerFactory<NotificationService>(
    () => NotificationService(),
  );

  getIt.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceService(),
  );

  /// Initialize for Datasource
  getIt.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSourceImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(
      getIt(),
    ),
  );

  /// Initialize for Repository
  getIt.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  /// Initialize for UseCase
  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<DetailUsecase>(
    () => DetailUsecase(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<FavoriteUsecase>(
    () => FavoriteUsecase(
      getIt(),
    ),
  );

  /// External
  getIt.registerFactory<DateTimeHelper>(
    () => DateTimeHelper(),
  );
}
