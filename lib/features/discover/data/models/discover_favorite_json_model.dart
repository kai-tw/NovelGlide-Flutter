import 'package:equatable/equatable.dart';

class DiscoverFavoriteJsonModel extends Equatable {
  const DiscoverFavoriteJsonModel({
    required this.version,
    required this.catalogList,
  });

  factory DiscoverFavoriteJsonModel.fromJson(Map<String, dynamic> json) {
    return DiscoverFavoriteJsonModel(
      version: json['version'],
      catalogList: json['catalogList'],
    );
  }

  final String version;
  final List<Map<String, dynamic>> catalogList;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'version': version,
      'catalogList': catalogList,
    };
  }

  @override
  List<Object?> get props => <Object?>[
        version,
        catalogList,
      ];
}
