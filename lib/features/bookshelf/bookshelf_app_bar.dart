import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_app_bar_popup_menu_button.dart';
import 'widgets/bookshelf_select_all_button.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) => previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, BookshelfState state) {
        return AppBar(
          leading: const Icon(Icons.book_outlined),
          title: Text(appLocalizations.bookshelfTitle),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: state.isSelecting
                  ? const BookshelfSelectAllButton()
                  : const SizedBox.shrink(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: state.isSelecting
                  ? TextButton(
                      onPressed: () => cubit.setSelecting(false),
                      child: Text(appLocalizations.generalDone),
                    )
                  : const SizedBox.shrink(),
            ),
            const BookshelfAppBarPopupMenuButton(),
          ],
        );
      },
    );
  }
}
