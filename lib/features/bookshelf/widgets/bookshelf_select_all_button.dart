import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookshelf_bloc.dart';

class BookshelfSelectAllButton extends StatelessWidget {
  const BookshelfSelectAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) => previous.selectedBooks != current.selectedBooks,
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelectedAll = state.selectedBooks.length == state.bookList.length;
        return TextButton(
          onPressed: isSelectedAll ? cubit.deselectAllBooks : cubit.selectAllBooks,
          child: Text(isSelectedAll ? appLocalizations.generalDeselectAll : appLocalizations.generalSelectAll),
        );
      },
    );
  }
}