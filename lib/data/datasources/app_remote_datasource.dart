import 'package:dio/dio.dart';
import 'package:simple_list_test/data/datasources/response/users_response.dart';

import '../../domain/entities/user_entity.dart';

abstract class AppRemoteDatasource {
  Future<List<UserEntity>> fetchUsers(int? page, int? perPage);
}

class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  final Dio dio;
  late final String baseUrl;

  AppRemoteDatasourceImpl({required this.dio}) {
    baseUrl = 'https://reqres.in/api';
    dio.options.baseUrl = baseUrl;
  }

  @override
  Future<List<UserEntity>> fetchUsers(int? page, int? perPage) async {
    final response = await dio.get("/users", queryParameters: {
      "page": page.toString(),
      "per_page": perPage.toString()
    });

    if (response.statusCode == 200) {
      return ApiUsersResponse.fromJson(response.data)
          .data!
          .map((e) => e.toEntity())
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
