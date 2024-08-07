import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/bookshelf_bloc.dart';

class BookshelfAppBarPopupMenuButton extends StatelessWidget {
  const BookshelfAppBarPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (context, state) {
        List<PopupMenuEntry<dynamic>> entries = [];

        /// Edit mode
        switch (cubit.state.code) {
          case BookshelfStateCode.normal:
            if (!cubit.state.isSelecting) {
              entries.add(PopupMenuItem(
                onTap: () => cubit.setSelecting(true),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(appLocalizations.generalEdit),
                    ),
                    const Icon(Icons.edit_rounded),
                  ],
                ),
              ));
            }
            break;
          default:
        }

        if (entries.isNotEmpty) {
          return PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            clipBehavior: Clip.hardEdge,
            itemBuilder: (BuildContext context) => entries,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
