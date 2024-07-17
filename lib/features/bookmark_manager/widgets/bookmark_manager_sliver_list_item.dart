import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/bookmark_data.dart';
import '../../common_components/bookmark_widget.dart';
import '../bloc/bookmark_manager_bloc.dart';

class BookmarkManagerSliverListItem extends StatelessWidget {
  final BookmarkData bookmarkData;

  const BookmarkManagerSliverListItem({super.key, required this.bookmarkData});

  @override
  Widget build(BuildContext context) {
    final BookmarkManagerCubit cubit = BlocProvider.of<BookmarkManagerCubit>(context);
    return InkWell(
      onTap: () {
        if (cubit.state.selectedBookmarks.contains(bookmarkData.bookName)) {
          cubit.deselectBookmark(bookmarkData.bookName);
        } else {
          cubit.selectBookmark(bookmarkData.bookName);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BookmarkWidget(
          bookmarkData,
          leading: BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
            builder: (BuildContext context, BookmarkManagerState state) {
              return Checkbox(
                value: state.selectedBookmarks.contains(bookmarkData.bookName),
                onChanged: (value) {
                  if (value == true) {
                    cubit.selectBookmark(bookmarkData.bookName);
                  } else {
                    cubit.deselectBookmark(bookmarkData.bookName);
                  }
                },
                semanticLabel: AppLocalizations.of(context)!.accessibilityBookmarkManagerCheckbox,
              );
            },
          ),
        ),
      ),
    );
  }
}
