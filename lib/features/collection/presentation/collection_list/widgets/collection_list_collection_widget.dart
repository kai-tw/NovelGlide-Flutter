import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../shared_components/adaptive_lines_text.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/collection_data.dart';

class CollectionListCollectionWidget extends StatelessWidget {
  const CollectionListCollectionWidget({
    super.key,
    required this.collectionData,
    required this.listType,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
  });

  final CollectionData collectionData;
  final SharedListType listType;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: _buildCollection(context),
    );
  }

  Widget _buildCollection(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (listType) {
      case SharedListType.grid:
        return SharedListGridItem(
          isSelecting: isSelecting,
          isSelected: isSelected,
          cover: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Icon(Icons.folder_rounded),
          ),
          title: AdaptiveLinesText(collectionData.name),
          onChanged: onChanged,
          semanticLabel: appLocalizations.collectionSelectCollection,
        );

      case SharedListType.list:
        return SharedListTile(
          isSelecting: isSelecting,
          isSelected: isSelected,
          leading: const Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(Icons.folder_rounded),
          ),
          title: Text(collectionData.name),
          onChanged: onChanged,
        );
    }
  }
}
