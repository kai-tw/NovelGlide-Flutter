import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_popup_menu.dart';
import 'widgets/bookmark_list_select_all_button.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final WindowClass windowClass =
        WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, BookmarkListState state) {
        return AppBar(
          leading: const Icon(Icons.bookmarks_outlined),
          leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
          title: Text(appLocalizations.bookmarkListTitle),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: state.isSelecting
                  ? const BookmarkListSelectAllButton()
                  : const SizedBox.shrink(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: state.isSelecting
                  ? TextButton(
                      onPressed: () => cubit.isSelecting = false,
                      child: Text(appLocalizations.generalDone),
                    )
                  : const SizedBox.shrink(),
            ),
            const BookmarkListPopupMenu(),
          ],
        );
      },
    );
  }
}
