import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/collection_data.dart';
import '../../collection_viewer/collection_viewer.dart';
import '../cubit/collection_list_cubit.dart';
import 'collection_list_draggable_collection.dart';

class CollectionListItem extends StatelessWidget {
  const CollectionListItem({
    super.key,
    required this.collectionData,
  });

  final CollectionData collectionData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(24.0),
      child: Semantics(
        label: appLocalizations.generalCollection(1),
        onTapHint: appLocalizations.collectionOpenCollection,
        onLongPressHint: appLocalizations.collectionDragCollectionToDelete,
        child: BlocBuilder<CollectionListCubit, CollectionListState>(
          buildWhen:
              (CollectionListState previous, CollectionListState current) =>
                  previous.code != current.code ||
                  previous.isSelecting != current.isSelecting ||
                  previous.isDragging != current.isDragging ||
                  previous.selectedSet.contains(collectionData) !=
                      current.selectedSet.contains(collectionData) ||
                  previous.listType != current.listType,
          builder: (BuildContext context, CollectionListState state) {
            return CollectionListDraggableCollection(
              collectionData: collectionData,
              listType: state.listType,
              isDraggable: state.code.isLoaded &&
                  !state.isSelecting &&
                  !state.isDragging,
              isSelecting: state.isSelecting,
              isSelected: state.selectedSet.contains(collectionData),
              onChanged: (_) => cubit.toggleSelectSingle(collectionData),
            );
          },
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);

    if (cubit.state.isSelecting) {
      cubit.toggleSelectSingle(collectionData);
    } else {
      Navigator.of(context)
          .push(
            MaterialPageRoute<void>(
              builder: (_) => CollectionViewer(collectionData: collectionData),
            ),
          )
          .then((_) => cubit.refresh());
    }
  }
}
