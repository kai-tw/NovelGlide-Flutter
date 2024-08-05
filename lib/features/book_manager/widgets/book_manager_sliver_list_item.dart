import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../bloc/book_manager_bloc.dart';

class BookManagerSliverListItem extends StatelessWidget {
  final BookData bookData;

  const BookManagerSliverListItem({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final BookManagerCubit cubit = BlocProvider.of<BookManagerCubit>(context);
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedBooks.contains(bookData.name) != current.selectedBooks.contains(bookData.name),
      builder: (BuildContext context, BookManagerState state) {
        final bool isSelected = state.selectedBooks.contains(bookData.name);
        return GestureDetector(
          onTap: () => _onTap(cubit, !cubit.state.selectedBooks.contains(bookData.name)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.errorContainer
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              textColor: isSelected ? Theme.of(context).colorScheme.onErrorContainer : null,
              leading: Checkbox(
                value: isSelected,
                onChanged: (value) => _onTap(cubit, value),
                activeColor: Colors.transparent,
                checkColor: Theme.of(context).colorScheme.onErrorContainer,
                semanticLabel: AppLocalizations.of(context)!.accessibilityBookManagerCheckbox,
              ),
              title: Text(bookData.name),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BookManagerCubit cubit, bool? value) {
    if (value == true) {
      cubit.selectBook(bookData.name);
    } else {
      cubit.deselectBook(bookData.name);
    }
  }
}
