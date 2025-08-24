import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/log_system/log_system.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/catalog_feed.dart';
import '../../../domain/use_cases/discover_browse_catalog_use_case.dart';
import 'discover_browser_state.dart';

class DiscoverBrowserCubit extends Cubit<DiscoverBrowserState> {
  DiscoverBrowserCubit(
    this._browseCatalogUseCase,
  ) : super(const DiscoverBrowserState());

  /// Use cases
  final DiscoverBrowseCatalogUseCase _browseCatalogUseCase;

  /// Controllers
  final TextEditingController textEditingController = TextEditingController();

  Future<void> browseCatalog([Uri? uri]) async {
    final String text = uri?.toString() ?? textEditingController.text;
    textEditingController.text = text;

    emit(const DiscoverBrowserState(
      code: LoadingStateCode.loading,
    ));

    try {
      final CatalogFeed feed = await _browseCatalogUseCase(text);

      if (!isClosed) {
        emit(DiscoverBrowserState(
          code: LoadingStateCode.loaded,
          catalogFeed: feed,
        ));
      }
    } catch (e, s) {
      LogSystem.error(
        'Failed to read the feed ($text)',
        error: e,
        stackTrace: s,
      );

      if (!isClosed) {
        emit(const DiscoverBrowserState(
          code: LoadingStateCode.error,
        ));
      }
    }
  }

  Future<void> downloadBook(Uri uri) async {
    // TODO(kai): Implement download book
    LogSystem.info('Download book: $uri');
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }
}
