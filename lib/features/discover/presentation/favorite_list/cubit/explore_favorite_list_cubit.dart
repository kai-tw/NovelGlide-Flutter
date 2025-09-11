import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/explore_favorite_catalog_data.dart';
import '../../../domain/use_cases/explore_get_favorite_list_use_case.dart';
import '../../../domain/use_cases/explore_observe_favorite_list_change_use_case.dart';
import 'explore_favorite_list_state.dart';

class ExploreFavoriteListCubit extends Cubit<ExploreFavoriteListState> {
  factory ExploreFavoriteListCubit(
    ExploreGetFavoriteListUseCase getFavoriteListUseCase,
    ExploreObserveFavoriteListChangeUseCase observeFavoriteListChangeUseCase,
  ) {
    final ExploreFavoriteListCubit cubit = ExploreFavoriteListCubit._(
      getFavoriteListUseCase,
    );

    cubit._onChangeSubscription = observeFavoriteListChangeUseCase()
        .listen((_) => cubit.getFavoriteList());

    return cubit;
  }

  ExploreFavoriteListCubit._(
    this._getFavoriteListUseCase,
  ) : super(const ExploreFavoriteListState());

  final ExploreGetFavoriteListUseCase _getFavoriteListUseCase;

  /// Stream subscriptions
  late final StreamSubscription<void> _onChangeSubscription;

  Future<void> getFavoriteList() async {
    emit(const ExploreFavoriteListState(code: LoadingStateCode.loading));

    final List<ExploreFavoriteCatalogData> catalogList =
        await _getFavoriteListUseCase();

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      catalogList: catalogList,
    ));
  }

  @override
  Future<void> close() async {
    await _onChangeSubscription.cancel();
    return super.close();
  }
}
