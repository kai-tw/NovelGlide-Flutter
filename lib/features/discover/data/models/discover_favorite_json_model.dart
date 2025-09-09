import 'package:equatable/equatable.dart';

import '../../domain/entities/discover_favorite_catalog_data.dart';

class DiscoverFavoriteJsonModel extends Equatable {
  const DiscoverFavoriteJsonModel({
    this.version = 1,
    this.identifierList = const <String>[],
    this.dataMap = const <String, DiscoverFavoriteCatalogData>{},
  });

  factory DiscoverFavoriteJsonModel.fromJson(Map<String, dynamic> json) {
    return const DiscoverFavoriteJsonModel().copyWith(
      version: int.tryParse(json['version'].toString()),
      identifierList: json['identifierList']?.whereType<String>().toList(),
      dataMap: (json['dataMap'] as Map<String, dynamic>?)?.map(
          (String k, dynamic j) =>
              MapEntry<String, DiscoverFavoriteCatalogData>(
                  k,
                  DiscoverFavoriteCatalogData(
                    identifier: j['identifier'].toString(),
                    name: j['name'].toString(),
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

  DiscoverFavoriteJsonModel copyWith({
    int? version,
    List<String>? identifierList,
    Map<String, DiscoverFavoriteCatalogData>? dataMap,
  }) {
    return DiscoverFavoriteJsonModel(
      version: version ?? this.version,
      identifierList: identifierList ?? this.identifierList,
      dataMap: dataMap ?? this.dataMap,
    );
  }
}
