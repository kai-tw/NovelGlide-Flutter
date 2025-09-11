import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/parser_system/domain/use_cases/uri_parser_parse_https_use_case.dart';
import '../../../domain/use_cases/explore_add_to_favorite_list_use_case.dart';
import 'explore_add_favorite_page_state.dart';

class ExploreAddFavoritePageCubit extends Cubit<ExploreAddFavoritePageState> {
  ExploreAddFavoritePageCubit(
    this._addToFavoriteListUseCase,
    this._parseHttpsUseCase,
  ) : super(const ExploreAddFavoritePageState());

  /// Use cases
  final DiscoverAddToFavoriteListUseCase _addToFavoriteListUseCase;
  final UriParserParseHttpsUseCase _parseHttpsUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void setName(String? name) =>
      emit(state.copyWithName(name?.isNotEmpty == true ? name : null));

  void setUrl(String? url) => emit(state.copyWithUrl(
        url?.isNotEmpty == true ? _parseHttpsUseCase(url!) : null,
      ));

  Future<bool> submit() async {
    if (formKey.currentState?.validate() ?? false) {
      // Save
      formKey.currentState?.save();

      if (state.isValid) {
        await _addToFavoriteListUseCase(ExploreAddToFavoriteListUseCaseParam(
          name: state.name!,
          uri: state.uri!,
        ));
        return true;
      }
    }

    return false;
  }
}
