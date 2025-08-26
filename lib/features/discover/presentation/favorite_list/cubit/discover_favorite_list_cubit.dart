import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/discover_favorite_catalog_data.dart';
import '../../../domain/use_cases/discover_get_favorite_list_use_case.dart';
import '../../../domain/use_cases/discover_observe_favorite_list_change_use_case.dart';
import 'discover_favorite_list_state.dart';

class DiscoverFavoriteListCubit extends Cubit<DiscoverFavoriteListState> {
  factory DiscoverFavoriteListCubit(
    DiscoverGetFavoriteListUseCase getFavoriteListUseCase,
    DiscoverObserveFavoriteListChangeUseCase observeFavoriteListChangeUseCase,
  ) {
    final DiscoverFavoriteListCubit cubit = DiscoverFavoriteListCubit._(
      getFavoriteListUseCase,
    );

    cubit._onChangeSubscription = observeFavoriteListChangeUseCase()
        .listen((_) => cubit.getFavoriteList());

    return cubit;
  }

  DiscoverFavoriteListCubit._(
    this._getFavoriteListUseCase,
  ) : super(const DiscoverFavoriteListState());

  final DiscoverGetFavoriteListUseCase _getFavoriteListUseCase;

  /// Stream subscriptions
  late final StreamSubscription<void> _onChangeSubscription;

  Future<void> getFavoriteList() async {
    emit(state.copyWith(code: LoadingStateCode.loading));
    final List<DiscoverFavoriteCatalogData> catalogList =
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
