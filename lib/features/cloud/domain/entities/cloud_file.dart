import 'package:equatable/equatable.dart';

class CloudFile extends Equatable {
  const CloudFile({
    required this.identifier,
    required this.name,
    required this.length,
    required this.modifiedTime,
  });

  final String identifier;
  final String name;
  final int length;
  final DateTime modifiedTime;

  @override
  List<Object?> get props => <Object?>[
        identifier,
        name,
        length,
        modifiedTime,
      ];
}
