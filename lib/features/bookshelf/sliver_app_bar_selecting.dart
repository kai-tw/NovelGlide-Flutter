import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/bookshelf_bloc.dart';

class BookshelfSliverAppBarSelecting extends StatelessWidget {
  const BookshelfSliverAppBarSelecting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelectedAll = state.selectedSet.length == state.bookList.length;
        return SliverAppBar(
          pinned: true,
          leading: IconButton(
            onPressed: () {
              if (isSelectedAll) {
                BlocProvider.of<BookshelfCubit>(context).clearSelect();
              } else {
                BlocProvider.of<BookshelfCubit>(context).allSelect();
              }
            },
            icon: Icon(isSelectedAll ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(state.selectedSet.length.toString()),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(context: context, builder: _confirmDialog).then((isDelete) {
                  if (isDelete) {
                    BlocProvider.of<BookshelfCubit>(context).deleteSelect();
                  }
                });
              },
              icon: const Icon(Icons.delete_outline_rounded),
            )
          ],
        );
      },
    );
  }

  Widget _confirmDialog(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delete_forever,
        size: 40.0,
      ),
      content: Text(
        AppLocalizations.of(context)!.confirm_content_delete,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
          child: Text(AppLocalizations.of(context)!.delete),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    );
  }
}
