import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/collection_data.dart';
import '../../data/window_class.dart';
import '../common_components/common_back_button.dart';
import 'bloc/collection_dialog_bloc.dart';
import 'collection_dialog_list.dart';

class CollectionDialog extends StatelessWidget {
  final CollectionData collectionData;

  const CollectionDialog({super.key, required this.collectionData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectionDialogCubit(collectionData)..init(),
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        child: Container(
          constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
          child: Scaffold(
            appBar: AppBar(
              leading: const CommonBackButton(),
              title: Text(collectionData.name),
            ),
            body: const CollectionDialogList(),
          ),
        ),
      ),
    );
  }
}