import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import '../../toolbox/route_helper.dart';
import '../common_components/bookmark_widget.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'widgets/bookmark_list_draggable_bookmark.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkData, {super.key});

  final BookmarkData _bookmarkData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24.0),
      onTap: () {
        final NavigatorState navigator = Navigator.of(context);

        if (cubit.state.isSelecting) {
          if (cubit.state.selectedBookmarks.contains(_bookmarkData)) {
            cubit.deselectBookmark(_bookmarkData);
          } else {
            cubit.selectBookmark(_bookmarkData);
          }
        } else {
          navigator
              .push(RouteHelper.pushRoute(ReaderWidget(bookPath: _bookmarkData.bookPath, isGotoBookmark: true)))
              .then((_) => cubit.refresh());
        }
      },
      child: BlocBuilder<BookmarkListCubit, BookmarkListState>(
        buildWhen: (previous, current) =>
            previous.isSelecting != current.isSelecting || previous.selectedBookmarks != current.selectedBookmarks,
        builder: (BuildContext context, BookmarkListState state) {
          if (state.isSelecting) {
            final bool isSelected = state.selectedBookmarks.contains(_bookmarkData);
            return Semantics(
              label: appLocalizations.bookmarkListAccessibilityItem,
              onTapHint: appLocalizations.bookmarkListAccessibilitySelectOnTap,
              child: BookmarkWidget(
                _bookmarkData,
                trailing: Checkbox(
                  value: isSelected,
                  activeColor: Colors.transparent,
                  checkColor: Theme.of(context).colorScheme.onErrorContainer,
                  onChanged: (bool? value) {
                    if (value == true) {
                      cubit.selectBookmark(_bookmarkData);
                    } else {
                      cubit.deselectBookmark(_bookmarkData);
                    }
                  },
                  semanticLabel: appLocalizations.bookmarkListAccessibilitySelectItem,
                ),
                backgroundColor: isSelected ? Theme.of(context).colorScheme.errorContainer : null,
                color: isSelected ? Theme.of(context).colorScheme.onErrorContainer : null,
              ),
            );
          } else {
            return Semantics(
              label: appLocalizations.bookmarkListAccessibilityItem,
              onTapHint: appLocalizations.bookmarkListAccessibilityOnTap,
              onLongPressHint: appLocalizations.bookmarkListAccessibilityOnLongPress,
              child: BookmarkListDraggableBookmark(_bookmarkData),
            );
          }
        },
      ),
    );
  }
}
