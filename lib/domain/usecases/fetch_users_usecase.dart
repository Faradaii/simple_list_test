import 'package:dartz/dartz.dart';

import '../../common/generic/failure.dart';
import '../../common/generic/success.dart';
import '../entities/user_entity.dart';
import '../repositories/app_repository.dart';

class FetchUsersUseCase {
  final AppRepository appRepository;

  FetchUsersUseCase({required this.appRepository});

  Future<Either<Failure, Success<List<UserEntity>>>> execute(
          int? page, int? perPage) =>
      appRepository.fetchUsers(page, perPage);
}
