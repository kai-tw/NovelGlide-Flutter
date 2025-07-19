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
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (listType) {
      case SharedListType.grid:
        return SharedListGridItem(
          isSelecting: isSelecting,
          isSelected: isSelected,
          cover: BookshelfCoverWidget(
            bookData: bookData,
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: AdaptiveLinesText(bookData.name),
          semanticLabel: appLocalizations.bookshelfSelectBook,
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
