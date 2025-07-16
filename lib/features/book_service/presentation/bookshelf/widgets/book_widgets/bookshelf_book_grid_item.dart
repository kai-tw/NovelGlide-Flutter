part of '../../../../book_service.dart';

class BookshelfBookGridItem extends StatelessWidget {
  const BookshelfBookGridItem({
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
    return Stack(
      children: <Widget>[
        // Book widget
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AspectRatio(
                aspectRatio: 1 / 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: BookCoverImage(
                    bookData: bookData,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              bookData.name,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        // Checkbox
        Positioned(
          top: 0.0,
          left: 0.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _buildCheckbox(context),
          ),
        ),
      ],
    );
  }

  /// Checkbox widgets builder
  Widget? _buildCheckbox(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    if (isSelecting) {
      return Checkbox(
        value: isSelected,
        onChanged: onChanged,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        semanticLabel: appLocalizations.bookshelfAccessibilityCheckbox,
      );
    }

    return null;
  }
}
