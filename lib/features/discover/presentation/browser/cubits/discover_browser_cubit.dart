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
    final Uri? requestedUri = uri ?? _parseUri(textEditingController.text);

    if (requestedUri == null || requestedUri.toString().isEmpty) {
      return;
    }

    final Uri? previousUri = state.currentUri;
    await _loadFeed(requestedUri);

    // Emit current uri
    emit(state.copyWith(
      currentUri: requestedUri,
      restoreStack: const <Uri>[],
    ));

    if (previousUri != null) {
      // Add the requested URI to the history stack and clear the restore stack
      emit(state.copyWith(
        historyStack: <Uri>[...state.historyStack, previousUri],
      ));
    }
  }

  Future<void> _loadFeed(Uri uri) async {
    textEditingController.text = uri.toString();

    emit(state.copyWith(
      code: LoadingStateCode.loading,
    ));

    try {
      final CatalogFeed feed = await _browseCatalogUseCase(uri);

      if (!isClosed) {
        emit(state.copyWith(
          code: LoadingStateCode.loaded,
          catalogFeed: feed,
        ));
      }
    } catch (e, s) {
      LogSystem.error(
        'Failed to read the feed ($uri)',
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

  /// Go to the previous catalog
  Future<void> previousCatalog() async {
    if (state.historyStack.isEmpty) {
      return;
    }

    final Uri? currentUri = state.currentUri;
    final Uri previousUri = state.historyStack.last;
    await _loadFeed(previousUri);

    // Emit previous uri.
    emit(state.copyWith(
      historyStack:
          state.historyStack.sublist(0, state.historyStack.length - 1),
      currentUri: previousUri,
    ));

    // Add the current uri to the restore stack.
    if (currentUri != null) {
      emit(state.copyWith(
        restoreStack: <Uri>[...state.restoreStack, currentUri],
      ));
    }
  }

  /// Go to the next catalog
  Future<void> nextCatalog() async {
    if (state.restoreStack.isEmpty) {
      return;
    }

    final Uri nextUri = state.restoreStack.last;
    final Uri? previousUri = state.currentUri;
    await _loadFeed(nextUri);

    // Emit current uri
    emit(state.copyWith(
      currentUri: nextUri,
      restoreStack:
          state.restoreStack.sublist(0, state.restoreStack.length - 1),
    ));

    if (previousUri != null) {
      // Add the requested URI to the history stack and clear the restore stack
      emit(state.copyWith(
        historyStack: <Uri>[...state.historyStack, previousUri],
      ));
    }
  }

  Future<void> goHome() async {
    emit(const DiscoverBrowserState());
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }

  Uri? _parseUri(String input) {
    Uri? uri;

    // Protocol check.
    if (!input.contains('://')) {
      uri ??= Uri.tryParse('https://$input');
    }

    uri ??= Uri.tryParse(input);

    return uri;
  }
}
