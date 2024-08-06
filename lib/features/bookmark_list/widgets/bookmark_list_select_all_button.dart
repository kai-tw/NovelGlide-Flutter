import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookmark_list_bloc.dart';

class BookmarkListSelectAllButton extends StatelessWidget {
  const BookmarkListSelectAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (previous, current) => previous.selectedBookmarks != current.selectedBookmarks,
      builder: (BuildContext context, BookmarkListState state) {
        final bool isSelectedAll = state.selectedBookmarks.length == state.bookmarkList.length;
        return TextButton(
          onPressed: isSelectedAll ? cubit.deselectAllBookmarks : cubit.selectAllBookmarks,
          child: Text(isSelectedAll ? appLocalizations.generalDeselectAll : appLocalizations.generalSelectAll),
        );
      },
    );
  }
}