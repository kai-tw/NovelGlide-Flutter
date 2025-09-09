import 'package:equatable/equatable.dart';

class ReaderSetStateData extends Equatable {
  const ReaderSetStateData({
    required this.breadcrumb,
    required this.chapterIdentifier,
    required this.startCfi,
    required this.chapterCurrentPage,
    required this.chapterTotalPage,
  });

  factory ReaderSetStateData.fromJson(Map<String, dynamic> json) =>
      ReaderSetStateData(
        breadcrumb: json['breadcrumb'],
        chapterIdentifier: json['chapterIdentifier'],
        startCfi: json['startCfi'],
        chapterCurrentPage: json['chapterCurrentPage'],
        chapterTotalPage: json['chapterTotalPage'],
      );

  final String? breadcrumb;
  final String? chapterIdentifier;
  final String? startCfi;
  final int? chapterCurrentPage;
  final int? chapterTotalPage;

  @override
  List<Object?> get props => <Object?>[
        breadcrumb,
        chapterIdentifier,
        startCfi,
        chapterCurrentPage,
        chapterTotalPage,
      ];
}
