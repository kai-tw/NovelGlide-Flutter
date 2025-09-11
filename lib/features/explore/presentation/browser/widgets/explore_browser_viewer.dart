import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../catalog_viewer/explore_catalog_viewer.dart';
import '../../favorite_list/explore_favorite_list.dart';
import '../cubits/explore_browser_cubit.dart';
import '../cubits/explore_browser_state.dart';

class ExploreBrowserViewer extends StatelessWidget {
  const ExploreBrowserViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);

    return BlocBuilder<ExploreBrowserCubit, ExploreBrowserState>(
      buildWhen: (ExploreBrowserState previous, ExploreBrowserState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ExploreBrowserState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
            return const ExploreFavoriteList();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loading:
            return const CommonLoadingWidget();

          case LoadingStateCode.error:
            // Error
            return CommonErrorWidget(
              content: appLocalizations.exploreFailedToLoadCatalog,
            );

          case LoadingStateCode.loaded:
            if (state.catalogFeed == null) {
              return const CommonErrorWidget();
            } else {
              return ExploreCatalogViewer(
                feed: state.catalogFeed!,
                onVisit: cubit.browseCatalog,
                onDownload: (Uri uri, String? entryTitle) async {
                  _showAddToDownloaderSnackBar(context);
                  cubit.downloadBook(uri, entryTitle);
                },
              );
            }
        }
      },
    );
  }

  void _showAddToDownloaderSnackBar(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appLocalizations.exploreBookAddedToDownloads),
      ),
    );
  }
}
