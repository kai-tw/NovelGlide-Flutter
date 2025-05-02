part of '../bookmark_list.dart';

class _BookmarkWidget extends StatelessWidget {
  const _BookmarkWidget(
    this._bookmarkData, {
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
    this.onTap,
  });

  final BookmarkData _bookmarkData;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int daysPassed = _bookmarkData.daysPassed;
    final String savedTimeString =
        _getSavedTimeString(daysPassed, appLocalizations);
    final String subtitle = (_bookmarkData.chapterTitle.isNotEmpty
            ? '${_bookmarkData.chapterTitle}\n'
            : '') +
        savedTimeString;

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: SharedListTile(
        isSelecting: isSelecting,
        isSelected: isSelected,
        leading: const Padding(
          padding: EdgeInsets.only(right: 14.0),
          child: Icon(Icons.bookmark_rounded),
        ),
        title: Text(_bookmarkData.bookName),
        subtitle: Text(subtitle),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
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

    savedTimeString = appLocalizations.savedTimeFunction(savedTimeString);
    return savedTimeString;
  }
}
