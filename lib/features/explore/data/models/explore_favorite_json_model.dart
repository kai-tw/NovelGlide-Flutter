import 'package:equatable/equatable.dart';

import '../../domain/entities/explore_favorite_catalog_data.dart';

class ExploreFavoriteJsonModel extends Equatable {
  const ExploreFavoriteJsonModel({
    this.version = 1,
    this.identifierList = const <String>[],
    this.dataMap = const <String, ExploreFavoriteCatalogData>{},
  });

  factory ExploreFavoriteJsonModel.fromJson(Map<String, dynamic> json) {
    return const ExploreFavoriteJsonModel().copyWith(
      version: int.tryParse(json['version'].toString()),
      identifierList: json['identifierList']?.whereType<String>().toList(),
      dataMap: (json['dataMap'] as Map<String, dynamic>?)?.map(
          (String k, dynamic j) => MapEntry<String, ExploreFavoriteCatalogData>(
              k,
              ExploreFavoriteCatalogData(
                identifier: j['identifier'].toString(),
                name: j['name'].toString(),
                uri: Uri.parse(j['uri']),
              ))),
    );
  }

  final int version;
  final List<String> identifierList;
  final Map<String, ExploreFavoriteCatalogData> dataMap;

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
      'dataMap': dataMap.map((String k, ExploreFavoriteCatalogData data) =>
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

  ExploreFavoriteJsonModel copyWith({
    int? version,
    List<String>? identifierList,
    Map<String, ExploreFavoriteCatalogData>? dataMap,
  }) {
    return ExploreFavoriteJsonModel(
      version: version ?? this.version,
      identifierList: identifierList ?? this.identifierList,
      dataMap: dataMap ?? this.dataMap,
    );
  }
}
