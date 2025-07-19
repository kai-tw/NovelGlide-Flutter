part of '../../../collection_service.dart';

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
          title: Column(
            children: <Widget>[
              Text(
                collectionData.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
