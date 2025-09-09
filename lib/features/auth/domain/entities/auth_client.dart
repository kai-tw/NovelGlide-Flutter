import 'package:http/http.dart';

class AuthClient extends BaseClient {
  AuthClient(this._headers);

  final Map<String, String> _headers;
  final Client _client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
