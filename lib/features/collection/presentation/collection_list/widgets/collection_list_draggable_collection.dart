import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../homepage/cubit/homepage_cubit.dart';
import '../../../../shared_components/draggable_feedback_widget.dart';
import '../../../../shared_components/draggable_placeholder_widget.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/collection_data.dart';
import '../cubit/collection_list_cubit.dart';
import 'collection_list_collection_widget.dart';

class CollectionListDraggableCollection extends StatelessWidget {
  const CollectionListDraggableCollection({
    super.key,
    required this.collectionData,
    required this.listType,
    required this.isDraggable,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
  });

  final CollectionData collectionData;
  final SharedListType listType;
  final bool isDraggable;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double? constraintHeight =
          listType == SharedListType.grid ? constraints.maxHeight : null;
      final EdgeInsets padding = listType == SharedListType.grid
          ? const EdgeInsets.all(8.0)
          : EdgeInsets.zero;
      return LongPressDraggable<CollectionData>(
        onDragStarted: () {
          cubit.isDragging = true;
          homepageCubit.isEnabled = false;
        },
        onDragEnd: (_) {
          cubit.isDragging = false;
          homepageCubit.isEnabled = true;
        },
        onDragCompleted: () async {
          await cubit.dragToDelete(collectionData);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocalizations.deleteCollectionSuccessfully),
              ),
            );
          }
        },
        data: collectionData,
        maxSimultaneousDrags: isDraggable ? 1 : 0,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          height: constraintHeight,
          padding: padding,
          child: CollectionListCollectionWidget(
            collectionData: collectionData,
            listType: listType,
          ),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          height: constraintHeight,
          padding: padding,
          child: CollectionListCollectionWidget(
            collectionData: collectionData,
            listType: listType,
          ),
        ),
        child: Container(
          width: constraints.maxWidth,
          height: constraintHeight,
          padding: padding,
          child: CollectionListCollectionWidget(
            collectionData: collectionData,
            listType: listType,
            isSelected: isSelected,
            isSelecting: isSelecting,
            onChanged: onChanged,
          ),
        ),
      );
    });
  }
}
