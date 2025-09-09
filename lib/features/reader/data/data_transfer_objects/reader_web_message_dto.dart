import 'package:equatable/equatable.dart';

class ReaderWebMessageDto extends Equatable {
  const ReaderWebMessageDto({
    required this.route,
    this.data,
  });

  factory ReaderWebMessageDto.fromJson(Map<String, dynamic> json) {
    return ReaderWebMessageDto(
      route: json['route'] as String,
      data: json['data'],
    );
  }

  final String route;
  final dynamic data;

  @override
  List<Object?> get props => <Object?>[route, data];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'route': route,
      'data': data,
    };
  }
}
