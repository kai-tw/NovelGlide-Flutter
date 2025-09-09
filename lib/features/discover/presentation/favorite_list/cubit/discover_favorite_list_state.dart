import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/discover_favorite_catalog_data.dart';

class DiscoverFavoriteListState extends Equatable {
  const DiscoverFavoriteListState({
    this.code = LoadingStateCode.initial,
    this.catalogList = const <DiscoverFavoriteCatalogData>[],
  });

  final LoadingStateCode code;
  final List<DiscoverFavoriteCatalogData> catalogList;

  @override
  List<Object> get props => <Object>[
        code,
        catalogList,
      ];

  DiscoverFavoriteListState copyWith({
    LoadingStateCode? code,
    List<DiscoverFavoriteCatalogData>? catalogList,
  }) {
    return DiscoverFavoriteListState(
      code: code ?? this.code,
      catalogList: catalogList ?? this.catalogList,
    );
  }
}
