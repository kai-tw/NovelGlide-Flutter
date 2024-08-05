import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_manager_bloc.dart';

class BookManagerTopBar extends StatelessWidget {
  const BookManagerTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookManagerCubit cubit = BlocProvider.of<BookManagerCubit>(context);
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedBooks != current.selectedBooks || previous.bookList != current.bookList,
      builder: (BuildContext context, BookManagerState state) {
        bool? checkBoxValue;

        if (state.bookList.isNotEmpty && state.bookList.length == state.selectedBooks.length) {
          checkBoxValue = true;
        } else if (state.selectedBooks.isNotEmpty) {
          checkBoxValue = null;
        } else {
          checkBoxValue = false;
        }

        return GestureDetector(
          onTap: () => _onTap(cubit),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                tristate: true,
                value: checkBoxValue,
                onChanged: (_) => _onTap(cubit),
                semanticLabel: appLocalizations.accessibilitySelectAllCheckbox,
              ),
              title: Text(appLocalizations.selectAll),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BookManagerCubit cubit) {
    if (cubit.state.selectedBooks.isEmpty) {
      cubit.selectAllBooks();
    } else {
      cubit.deselectAllBooks();
    }
  }
}
