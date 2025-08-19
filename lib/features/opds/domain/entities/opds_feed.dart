import 'package:equatable/equatable.dart';

class OpdsFeed extends Equatable {
  const OpdsFeed({
    required this.id,
    required this.title,
    required this.updated,
    // required this.links,
    // required this.entries,
  });

  final String id;
  final String title;
  final DateTime updated;
  // final List<OpdsLink> links;
  // final List<OpdsEntry> entries;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        updated,
      ];
}
