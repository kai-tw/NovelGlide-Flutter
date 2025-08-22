import 'package:equatable/equatable.dart';

import '../../domain/entities/discover_favorite_catalog_data.dart';

class DiscoverFavoriteJsonModel extends Equatable {
  const DiscoverFavoriteJsonModel({
    this.version = 1,
    required this.identifierList,
    required this.dataMap,
  });

  factory DiscoverFavoriteJsonModel.fromJson(Map<String, dynamic> json) {
    return DiscoverFavoriteJsonModel(
      version: json['version'],
      identifierList: json['identifierList'],
      dataMap: (json['dataMap'] as Map<String, dynamic>)
          .map((String k, j) => MapEntry<String, DiscoverFavoriteCatalogData>(
              k,
              DiscoverFavoriteCatalogData(
                identifier: j['identifier'],
                name: j['name'],
                uri: Uri.parse(j['uri']),
              ))),
    );
  }

  final int version;
  final List<String> identifierList;
  final Map<String, DiscoverFavoriteCatalogData> dataMap;

  @override
  List<Object?> get props => <Object?>[
        version,
        identifierList,
        dataMap,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'version': version,
      'identifierList': identifierList,
      'dataMap': dataMap.map((String k, DiscoverFavoriteCatalogData data) =>
          MapEntry<String, Map<String, dynamic>>(
            k,
            <String, dynamic>{
              'identifier': data.identifier,
              'name': data.name,
              'uri': data.uri.toString(),
            },
          )),
    };
  }
}
