import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/explore_favorite_catalog_data.dart';

class ExploreFavoriteListState extends Equatable {
  const ExploreFavoriteListState({
    this.code = LoadingStateCode.initial,
    this.catalogList = const <ExploreFavoriteCatalogData>[],
  });

  final LoadingStateCode code;
  final List<ExploreFavoriteCatalogData> catalogList;

  @override
  List<Object> get props => <Object>[
        code,
        catalogList,
      ];

  ExploreFavoriteListState copyWith({
    LoadingStateCode? code,
    List<ExploreFavoriteCatalogData>? catalogList,
  }) {
    return ExploreFavoriteListState(
      code: code ?? this.code,
      catalogList: catalogList ?? this.catalogList,
    );
  }
}
