part of '../../../../book_service.dart';

class BookshelfBookListItem extends StatelessWidget {
  const BookshelfBookListItem({
    super.key,
    required this.bookData,
    required this.isSelecting,
    required this.isSelected,
    this.onChanged,
  });

  final BookData bookData;
  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SharedListTile(
      isSelecting: isSelecting,
      isSelected: isSelected,
      onChanged: onChanged,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
        child: AspectRatio(
          aspectRatio: 1 / 1.5,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: BookCoverImage(
              bookData: bookData,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        bookData.name,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
