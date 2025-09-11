abstract class HttpClientRepository {
  Future<T?> get<T>(Uri uri);
}
