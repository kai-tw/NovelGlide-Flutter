import 'package:dio/dio.dart';

import '../../domain/repositories/http_client_repository.dart';

class HttpClientRepositoryImpl implements HttpClientRepository {
  HttpClientRepositoryImpl();

  final Dio dio = Dio();

  @override
  Future<T?> get<T>(Uri uri) async {
    final Response<T> response = await dio.get(uri.toString());
    return response.data;
  }
}
