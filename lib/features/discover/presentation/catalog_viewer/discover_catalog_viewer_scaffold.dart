import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/discover_catalog_viewer_cubit.dart';

class DiscoverCatalogViewerScaffold extends StatelessWidget {
  const DiscoverCatalogViewerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverCatalogViewerCubit cubit =
        BlocProvider.of<DiscoverCatalogViewerCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: cubit.textEditingController,
                ),
              ),
              IconButton(
                onPressed: cubit.browseCatalog,
                icon: const Icon(Icons.search_rounded),
              ),
            ],
          ),
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
