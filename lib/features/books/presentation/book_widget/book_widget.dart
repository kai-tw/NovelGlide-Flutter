import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/adaptive_lines_text.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/book_cover.dart';
import '../book_cover/shared_book_cover_widget.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.bookData,
    required this.coverData,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
    required this.listType,
    this.trailing,
  });

  final Book bookData;
  final BookCover coverData;
  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final SharedListType listType;
  final Widget? trailing;

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
          onChanged: onChanged,
          cover: SharedBookCoverWidget(
            coverData: coverData,
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: AdaptiveLinesText(bookData.title),
          semanticLabel: appLocalizations.tapToSelectBook,
        );

      case SharedListType.list:
        return SharedListTile(
          isSelecting: isSelecting,
          isSelected: isSelected,
          onChanged: onChanged,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
            child: SharedBookCoverWidget(
              coverData: coverData,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          title: Text(
            bookData.title,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: trailing,
        );
    }
  }
}
