import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'cubits/discover_catalog_viewer_cubit.dart';
import 'discover_catalog_viewer_scaffold.dart';

class CatalogViewer extends StatelessWidget {
  const CatalogViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscoverCatalogViewerCubit>(
      create: (_) => sl<DiscoverCatalogViewerCubit>(),
      child: const DiscoverCatalogViewerScaffold(),
    );
  }
}
