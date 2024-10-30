import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/collection_data.dart';
import '../common_components/common_back_button.dart';
import 'bloc/collection_viewer_bloc.dart';
import 'collection_viewer_list.dart';

class CollectionViewer extends StatelessWidget {
  final CollectionData collectionData;

  const CollectionViewer({super.key, required this.collectionData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectionViewerCubit(collectionData),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(collectionData.name),
        ),
        body: const SafeArea(
          child: CollectionViewerList(),
        ),
      ),
    );
  }
}
