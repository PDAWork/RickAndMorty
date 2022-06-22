import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty/domain/repositories/person_repository.dart';
import 'package:rick_and_morty/domain/usercases/get_all_persons.dart';
import 'package:rick_and_morty/domain/usercases/search_persons.dart';
import 'package:rick_and_morty/presentation/state/person_list_cubit/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/presentation/state/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc/Cubit

  sl.registerFactory(() => PersonListCubuit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPersons: sl()));

  //UseCases

  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  //Repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api/',
          connectTimeout: 1500,
          sendTimeout: 1500,
          receiveTimeout: 1500,
        ),
      ),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api/',
          connectTimeout: 1500,
          sendTimeout: 1500,
          receiveTimeout: 1500,
        ),
      ));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
