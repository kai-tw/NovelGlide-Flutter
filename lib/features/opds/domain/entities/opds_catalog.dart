import 'package:equatable/equatable.dart';

class OPDSCatalog extends Equatable {
  const OPDSCatalog({
    required this.title,
    this.subtitle = '',
    required this.updatedTime,
  });

  final String title;
  final String subtitle;
  final DateTime updatedTime;

  @override
  List<Object?> get props => <Object?>[
        title,
        subtitle,
        updatedTime,
      ];
}
