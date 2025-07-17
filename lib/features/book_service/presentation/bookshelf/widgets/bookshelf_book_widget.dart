part of '../../../book_service.dart';

class BookshelfBookWidget extends StatelessWidget {
  const BookshelfBookWidget({
    super.key,
    required this.bookData,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
    required this.listType,
  });

  final BookData bookData;
  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final SharedListType listType;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: _buildItem(context),
    );
  }

  Widget _buildItem(BuildContext context) {
    switch (listType) {
      case SharedListType.grid:
        return SharedListGridItem(
          isSelecting: isSelecting,
          isSelected: isSelected,
          cover: BookshelfCoverWidget(
            bookData: bookData,
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            bookData.name,
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );

      case SharedListType.list:
        return SharedListTile(
          isSelecting: isSelecting,
          isSelected: isSelected,
          onChanged: onChanged,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
            child: BookshelfCoverWidget(
              bookData: bookData,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          title: Text(
            bookData.name,
            overflow: TextOverflow.ellipsis,
          ),
        );
    }
  }
}
