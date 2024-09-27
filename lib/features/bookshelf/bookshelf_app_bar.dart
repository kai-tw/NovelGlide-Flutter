import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
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
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    return AppBar(
      leading: const Icon(Icons.book_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookshelfTitle),
      actions: [
        BlocBuilder<BookshelfCubit, BookshelfState>(
          buildWhen: (previous, current) => previous.isSelecting != current.isSelecting,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: state.isSelecting ? const BookshelfSelectAllButton() : null,
            );
          },
        ),
        BlocBuilder<BookshelfCubit, BookshelfState>(
          buildWhen: (previous, current) => previous.isSelecting != current.isSelecting,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: state.isSelecting
                  ? TextButton(onPressed: () => cubit.setSelecting(false), child: Text(appLocalizations.generalDone))
                  : null,
            );
          },
        ),
        const BookshelfAppBarPopupMenuButton(),
      ],
    );
  }
}
