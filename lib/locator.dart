import 'package:be_loved/features/home/data/datasource/be_loved_remote_datasource.dart';
import 'package:be_loved/features/home/data/datasource/be_loved_remote_datasource_impl.dart';
import 'package:be_loved/features/home/data/datasource/events/events_remote_datasource.dart';
import 'package:be_loved/features/home/data/datasource/tags/tags_remote_datasource.dart';
import 'package:be_loved/features/home/data/repository/be_loved_implement.dart';
import 'package:be_loved/features/home/data/repository/events_repository_impl.dart';
import 'package:be_loved/features/home/data/repository/tags_repository_impl.dart';
import 'package:be_loved/features/home/domain/repositories/be_loved.dart';
import 'package:be_loved/features/home/domain/repositories/events_repository.dart';
import 'package:be_loved/features/home/domain/repositories/tags_repository.dart';
import 'package:be_loved/features/home/domain/usecases/add_event.dart';
import 'package:be_loved/features/home/domain/usecases/add_tag.dart';
import 'package:be_loved/features/home/domain/usecases/change_position_event.dart';
import 'package:be_loved/features/home/domain/usecases/delete_event.dart';
import 'package:be_loved/features/home/domain/usecases/get_events.dart';
import 'package:be_loved/features/home/domain/usecases/get_tags.dart';
import 'package:be_loved/features/home/domain/usecases/post_number.dart';
import 'package:be_loved/features/home/domain/usecases/put_code.dart';
import 'package:be_loved/features/home/presentation/bloc/events/events_bloc.dart';
import 'package:be_loved/features/home/presentation/bloc/tags/tags_bloc.dart';
import 'package:be_loved/features/home/presentation/views/relationships/account/controller/account_page_cubit.dart';
import 'package:be_loved/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:be_loved/features/profile/domain/repositories/profile_repository.dart';
import 'package:be_loved/features/profile/domain/usecases/edit_profile.dart';
import 'package:be_loved/features/profile/domain/usecases/edit_relation.dart';
import 'package:be_loved/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'constants/main_config_app.dart';
import 'core/services/database/auth_params.dart';
import 'core/services/network/config.dart';
import 'core/services/network/network_info.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';

final sl = GetIt.instance;

void setupInjections() {
  //Main config of system
  sl.registerLazySingleton<MainConfigApp>(() => MainConfigApp());

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory<Dio>(
    () => Dio(BaseOptions(baseUrl: Config.url.url)),
  );

  ///Authentication
  sl.registerLazySingleton<AuthConfig>(() => AuthConfig());
  // //Datasources
  // sl.registerLazySingleton<AuthenticationRemoteDataSource>(
  //   () => AuthenticationRemoteDataSourceImpl(dio: sl()),
  // );
  // sl.registerLazySingleton<AuthenticationLocalDataSource>(
  //   () => AuthenticationLocalDataSourceImpl(),
  // );

  // // //Repositories
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(sl(), sl(), sl()),
  // );

  // // //UseCases
  // sl.registerLazySingleton(() => SendCodeResetPassword(sl()));

  // //Blocs
  // sl.registerFactory<AuthBloc>(
  //   () => AuthBloc(sl(), sl(), sl(), sl(), sl()),
  // );

  //Repository
  sl.registerLazySingleton<BelovedRepository>(
      () => BelovedRepositoryImplement(sl()));
  //Usecase
  sl.registerLazySingleton(() => PostNumber(sl()));
  sl.registerLazySingleton(() => PutCode(sl()));
  // //Cubit
  // sl.registerFactory(() => AccountCubit(postNumber: sl(), putCode: sl()));
  //Datasource
  sl.registerLazySingleton<BeLovedRemoteDatasource>(
      () => BeLovedRemoteDatasourceImpl(dio: sl()));

  



  //Datasources
  sl.registerLazySingleton<EventsRemoteDataSource>(
    () => EventsRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepositoryImpl(sl(), sl()),
  );

  // //UseCases
  sl.registerLazySingleton(() => AddEvent(sl()));
  sl.registerLazySingleton(() => DeleteEvent(sl()));
  sl.registerLazySingleton(() => ChangePositionEvent(sl()));
  sl.registerLazySingleton(() => GetEvents(sl()));

  //Blocs
  sl.registerFactory<EventsBloc>(
    () => EventsBloc(sl(), sl(), sl(), sl()),
  );






  //Datasources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  // //UseCases
  sl.registerLazySingleton(() => EditProfile(sl()));
  sl.registerLazySingleton(() => EditRelation(sl()));

  //Blocs
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl(), sl(), sl(), sl()),
  );








  //Datasources
  sl.registerLazySingleton<TagsRemoteDataSource>(
    () => TagsRemoteDataSourceImpl(dio: sl()),
  );

  // //Repositories
  sl.registerLazySingleton<TagsRepository>(
    () => TagsRepositoryImpl(sl(), sl()),
  );

  // //UseCases
  sl.registerLazySingleton(() => AddTag(sl()));
  sl.registerLazySingleton(() => GetTags(sl()));

  //Blocs
  sl.registerFactory<TagsBloc>(
    () => TagsBloc(sl(), sl()),
  );
}
