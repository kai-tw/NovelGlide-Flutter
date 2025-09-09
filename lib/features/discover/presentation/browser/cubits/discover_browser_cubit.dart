import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/parser_system/domain/use_cases/uri_parser_parse_https_use_case.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../books/domain/use_cases/book_download_and_add_use_case.dart';
import '../../../domain/entities/catalog_feed.dart';
import '../../../domain/use_cases/discover_add_to_favorite_list_use_case.dart';
import '../../../domain/use_cases/discover_browse_catalog_use_case.dart';
import '../../../domain/use_cases/discover_get_favorite_identifier_by_uri_use_case.dart';
import '../../../domain/use_cases/discover_remove_from_favorite_list_use_case.dart';
import 'discover_browser_state.dart';

class DiscoverBrowserCubit extends Cubit<DiscoverBrowserState> {
  DiscoverBrowserCubit(
    this._browseCatalogUseCase,
    this._getFavoriteIdentifierByUriUseCase,
    this._removeFromFavoriteListUseCase,
    this._addToFavoriteListUseCase,
    this._parseHttpsUseCase,
    this._bookDownloadAndAddUseCase,
  ) : super(const DiscoverBrowserState());

  /// Browser use cases
  final DiscoverBrowseCatalogUseCase _browseCatalogUseCase;

  /// Favorite use cases
  final DiscoverGetFavoriteIdentifierByUriUseCase
      _getFavoriteIdentifierByUriUseCase;
  final DiscoverRemoveFromFavoriteListUseCase _removeFromFavoriteListUseCase;
  final DiscoverAddToFavoriteListUseCase _addToFavoriteListUseCase;

  /// Use cases
  final UriParserParseHttpsUseCase _parseHttpsUseCase;
  final BookDownloadAndAddUseCase _bookDownloadAndAddUseCase;

  /// Controllers
  final TextEditingController textEditingController = TextEditingController();

  Future<void> browseCatalog([Uri? uri]) async {
    final Uri? requestedUri =
        uri ?? _parseHttpsUseCase(textEditingController.text);
    final Uri? previousUri = state.currentUri;

    if (requestedUri == null ||
        requestedUri.toString().isEmpty ||
        previousUri == requestedUri) {
      return;
    }

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

    await _loadFeed(requestedUri);
  }

  Future<void> _loadFeed(Uri uri) async {
    textEditingController.text = uri.toString();

    if (!isClosed) {
      emit(state.copyWith(
        code: LoadingStateCode.loading,
      ));
    }

    final String? favoriteIdentifier =
        await _getFavoriteIdentifierByUriUseCase(uri);
    final CatalogFeed? feed = await _browseCatalogUseCase(uri);

    if (!isClosed) {
      if (feed == null) {
        emit(const DiscoverBrowserState(
          code: LoadingStateCode.error,
        ));
      } else {
        final DiscoverBrowserState newState = state
            .copyWith(
              code: LoadingStateCode.loaded,
              catalogFeed: feed,
            )
            .copyWithFavoriteIdentifier(favoriteIdentifier);

        emit(newState);
      }
    }
  }

  Future<void> downloadBook(Uri uri, String? entryTitle) async {
    return _bookDownloadAndAddUseCase(BookDownloadAndAddUseCaseParam(
      uri: uri,
      name: entryTitle ?? state.catalogFeed?.title ?? '',
    ));
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

  Future<void> addToFavoriteList({String? name}) async {
    if (state.currentUri == null) {
      return;
    }
    await _addToFavoriteListUseCase(DiscoverAddToFavoriteListUseCaseParam(
      name: name ?? state.catalogFeed?.title ?? '',
      uri: state.currentUri!,
    ));

    if (!isClosed) {
      emit(state.copyWithFavoriteIdentifier(
        await _getFavoriteIdentifierByUriUseCase(
          state.currentUri!,
        ),
      ));
    }
  }

  Future<void> removeFromFavoriteList([String? identifier]) async {
    final String? identifierToPass = identifier ?? state.favoriteIdentifier;
    if (identifierToPass == null) {
      return;
    }

    await _removeFromFavoriteListUseCase(identifierToPass);

    if (!isClosed) {
      emit(state.copyWithFavoriteIdentifier(null));
    }
  }
}
