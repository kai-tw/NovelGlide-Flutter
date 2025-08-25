import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/discover_favorite_catalog_data.dart';
import '../../../domain/use_cases/discover_get_favorite_list_use_case.dart';
import 'discover_favorite_list_state.dart';

class DiscoverFavoriteListCubit extends Cubit<DiscoverFavoriteListState> {
  DiscoverFavoriteListCubit(
    this._getFavoriteListUseCase,
  ) : super(const DiscoverFavoriteListState());

  final DiscoverGetFavoriteListUseCase _getFavoriteListUseCase;

  Future<void> getFavoriteList() async {
    emit(state.copyWith(code: LoadingStateCode.loading));
    final List<DiscoverFavoriteCatalogData> catalogList =
        await _getFavoriteListUseCase();
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      catalogList: catalogList,
    ));
  }
}
