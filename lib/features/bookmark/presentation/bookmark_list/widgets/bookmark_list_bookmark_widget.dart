part of '../../../bookmark_service.dart';

class BookmarkListBookmarkWidget extends StatelessWidget {
  const BookmarkListBookmarkWidget({
    super.key,
    required this.bookmarkData,
    required this.listType,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
  });

  final BookmarkData bookmarkData;
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
      child: _buildBookmark(context),
    );
  }

  Widget _buildBookmark(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int daysPassed = bookmarkData.daysPassed;
    final List<Widget> subtitleChildren = <Widget>[
      // Days passed text
      Text(_getSavedTimeString(daysPassed, appLocalizations)),
    ];

    switch (listType) {
      case SharedListType.grid:
        // Chapter title
        if (bookmarkData.chapterTitle.isNotEmpty) {
          subtitleChildren.insert(
            0,
            Text(
              bookmarkData.chapterTitle,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        return SharedListGridItem(
          isSelecting: isSelecting,
          isSelected: isSelected,
          cover: const Icon(Icons.bookmark_rounded),
          title: Column(
            children: <Widget>[
              Text(
                bookmarkData.bookName,
                overflow: TextOverflow.ellipsis,
              ),
              ...subtitleChildren,
            ],
          ),
          onChanged: onChanged,
        );

      case SharedListType.list:
        // Chapter title
        if (bookmarkData.chapterTitle.isNotEmpty) {
          subtitleChildren.insert(0, Text(bookmarkData.chapterTitle));
        }

        return SharedListTile(
          isSelecting: isSelecting,
          isSelected: isSelected,
          leading: const Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(Icons.bookmark_rounded),
          ),
          title: Text(bookmarkData.bookName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subtitleChildren,
          ),
          onChanged: onChanged,
        );
    }
  }

  String _getSavedTimeString(
    int daysPassed,
    AppLocalizations appLocalizations,
  ) {
    String savedTimeString = '';

    switch (daysPassed) {
      case 0:
        savedTimeString = appLocalizations.savedTimeToday;
        break;
      case 1:
        savedTimeString = appLocalizations.savedTimeYesterday;
        break;
      default:
        savedTimeString = appLocalizations.savedTimeOthersFunction(daysPassed);
    }

    return appLocalizations.savedTimeFunction(savedTimeString);
  }
}
