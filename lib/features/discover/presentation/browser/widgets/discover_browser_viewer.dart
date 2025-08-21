import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../catalog_viewer/discover_catalog_viewer.dart';
import '../cubits/discover_browser_cubit.dart';
import '../cubits/discover_browser_state.dart';

class DiscoverBrowserViewer extends StatelessWidget {
  const DiscoverBrowserViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code,
      builder: (BuildContext context, DiscoverBrowserState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
            return const Center(
              child: Text('Type url'),
            );

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loading:
            return const CommonLoadingWidget();

          case LoadingStateCode.error:
            // Error
            return const CommonErrorWidget();

          case LoadingStateCode.loaded:
            if (state.catalogFeed == null) {
              // Something went wrong
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return DiscoverCatalogViewer(
                feed: state.catalogFeed!,
                onVisit: (Uri uri) => cubit.browseCatalog(uri),
              );
            }
        }
      },
    );
  }
}
