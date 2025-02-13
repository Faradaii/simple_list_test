import 'package:dartz/dartz.dart';
import 'package:simple_list_test/common/generic/failure.dart';
import 'package:simple_list_test/common/generic/success.dart';

import '../entities/user_entity.dart';

abstract class AppRepository {
  bool checkPalindrome(String text);
  Future<Either<Failure, Success<List<UserEntity>>>> fetchUsers(
      int? page, int? perPage);
}
