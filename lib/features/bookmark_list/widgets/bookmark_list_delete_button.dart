import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_delete_dialog.dart';
import '../bloc/bookmark_list_bloc.dart';

class BookmarkListDeleteButton extends StatelessWidget {
  const BookmarkListDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDeleteDialog(
              onDelete: () => cubit.deleteSelectedBookmarks(),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(double.infinity, 56.0),
        minimumSize: const Size(double.infinity, 56.0),
      ),
      icon: const Icon(Icons.delete_rounded),
      label: BlocBuilder<BookmarkListCubit, BookmarkListState>(
        buildWhen: (previous, current) => previous.selectedBookmarks != current.selectedBookmarks,
        builder: (context, state) {
          return Text(appLocalizations.bookmarkListDeleteNumberOfSelectedBookmarks(state.selectedBookmarks.length));
        },
      ),
    );
  }
}