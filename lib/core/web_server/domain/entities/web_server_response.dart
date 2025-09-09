import 'package:equatable/equatable.dart';

class WebServerResponse extends Equatable {
  const WebServerResponse({
    required this.body,
    this.headers,
  });

  final Object body;
  final Map<String, Object>? headers;

  @override
  List<Object?> get props => <Object?>[
        body,
        headers,
      ];
}
