part of '../collection_list.dart';

class _CollectionWidget extends StatelessWidget {
  final CollectionData collectionData;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  const _CollectionWidget(
    this.collectionData, {
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: CommonListSelectableListTile(
        isSelecting: isSelecting,
        isSelected: isSelected,
        leading: const Padding(
          padding: EdgeInsets.only(right: 14.0),
          child: Icon(Icons.folder_rounded),
        ),
        title: Text(collectionData.name),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
