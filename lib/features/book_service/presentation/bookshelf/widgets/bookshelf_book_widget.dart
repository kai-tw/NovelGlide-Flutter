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
      child: _buildItem(),
    );
  }

  Widget _buildItem() {
    switch (listType) {
      case SharedListType.grid:
        return BookshelfBookGridItem(
          bookData: bookData,
          isSelecting: isSelecting,
          isSelected: isSelected,
          onChanged: onChanged,
        );
      case SharedListType.list:
        return BookshelfBookListItem(
          bookData: bookData,
          isSelecting: isSelecting,
          isSelected: isSelected,
          onChanged: onChanged,
        );
    }
  }
}
