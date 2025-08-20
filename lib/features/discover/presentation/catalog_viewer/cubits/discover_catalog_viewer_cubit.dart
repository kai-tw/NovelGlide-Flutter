import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/catalog_feed.dart';
import '../../../domain/use_cases/discover_browse_catalog_use_case.dart';
import 'discover_catalog_viewer_state.dart';

class DiscoverCatalogViewerCubit extends Cubit<DiscoverCatalogViewerState> {
  DiscoverCatalogViewerCubit(
    this._browseCatalogUseCase,
  ) : super(const DiscoverCatalogViewerState());

  /// Use cases
  final DiscoverBrowseCatalogUseCase _browseCatalogUseCase;

  /// Controllers
  final TextEditingController textEditingController = TextEditingController();

  Future<void> browseCatalog() async {
    final String text = textEditingController.text;

    emit(const DiscoverCatalogViewerState(
      code: LoadingStateCode.loading,
    ));

    final CatalogFeed feed = await _browseCatalogUseCase(text);
    print(feed);

    if (!isClosed) {
      emit(DiscoverCatalogViewerState(
        code: LoadingStateCode.loaded,
        feed: feed,
      ));
    }
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }
}
