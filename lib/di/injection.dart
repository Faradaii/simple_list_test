
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_list_test/data/datasources/app_remote_datasource.dart';
import 'package:simple_list_test/data/repositories/app_repository_impl.dart';
import 'package:simple_list_test/domain/repositories/app_repository.dart';
import 'package:simple_list_test/domain/usecases/check_palindrome_usecase.dart';
import 'package:simple_list_test/domain/usecases/fetch_users_usecase.dart';
import 'package:simple_list_test/presentation/bloc/shared_bloc.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<AppRemoteDatasource>(
        () => AppRemoteDatasourceImpl(dio: getIt()),
  );

  getIt.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => CheckPalindromeUseCase(appRepository: getIt()));
  getIt.registerLazySingleton(() => FetchUsersUseCase(appRepository: getIt()));

  getIt.registerLazySingleton(() => SharedBloc(checkPalindromeUseCase: getIt(), fetchUsersUseCase: getIt()));
}