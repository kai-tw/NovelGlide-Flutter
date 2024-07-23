import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_manager_bloc.dart';

class BookManagerTopBar extends StatelessWidget {
  const BookManagerTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BookManagerCubit cubit = BlocProvider.of<BookManagerCubit>(context);
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedBooks != current.selectedBooks || previous.bookList != current.bookList,
      builder: (BuildContext context, BookManagerState state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: InkWell(
            onTap: () => _onTap(cubit),
            child: Row(
              children: [
                Checkbox(
                  tristate: true,
                  value: state.bookList.isNotEmpty && state.bookList.length == state.selectedBooks.length
                      ? true
                      : state.selectedBooks.isNotEmpty
                          ? null
                          : false,
                  onChanged: (_) => _onTap(cubit),
                  semanticLabel: AppLocalizations.of(context)!.accessibilitySelectAllCheckbox,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.selectAll,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
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
