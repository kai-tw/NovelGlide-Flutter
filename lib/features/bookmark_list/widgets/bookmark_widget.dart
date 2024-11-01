part of '../bookmark_list.dart';

class BookmarkWidget extends StatelessWidget {
  final BookmarkData _bookmarkData;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  const BookmarkWidget(
    this._bookmarkData, {
    super.key,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final daysPassed = _bookmarkData.daysPassed;
    final savedTimeString = _getSavedTimeString(daysPassed, appLocalizations);

    if (isSelecting) {
      return CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        value: isSelected,
        onChanged: onChanged,
        secondary: const Padding(
          padding: EdgeInsets.only(right: 14.0),
          child: Icon(Icons.bookmark_rounded),
        ),
        title: Text(_bookmarkData.bookName),
        subtitle: Text('${_bookmarkData.chapterTitle}\n$savedTimeString'),
      );
    } else {
      return Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          onTap: onTap,
          leading: const Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(Icons.bookmark_rounded),
          ),
          title: Text(_bookmarkData.bookName),
          subtitle: Text('${_bookmarkData.chapterTitle}\n$savedTimeString'),
        ),
      );
    }
  }

  String _getSavedTimeString(
    int daysPassed,
    AppLocalizations appLocalizations,
  ) {
    String savedTimeString = "";

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

    savedTimeString = appLocalizations.savedTimeFunction(savedTimeString);
    return savedTimeString;
  }
}
