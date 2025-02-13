import 'package:dartz/dartz.dart';

import 'package:simple_list_test/common/generic/failure.dart';

import 'package:simple_list_test/common/generic/success.dart';
import 'package:simple_list_test/data/datasources/app_remote_datasource.dart';

import 'package:simple_list_test/domain/entities/user_entity.dart';

import '../../domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDatasource appRemoteDatasource;

  AppRepositoryImpl(this.appRemoteDatasource);

  @override
  bool checkPalindrome(String text) {
    String reverseText = text.toLowerCase().split('').reversed.join('');
    return text == reverseText;
  }

  @override
  Future<Either<Failure, Success<List<UserEntity>>>> fetchUsers(
      int? page, int? perPage) async {
    try {
      final apiResult = await appRemoteDatasource.fetchUsers(page, perPage);
      return Right(Success(message: 'Success', data: apiResult));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
