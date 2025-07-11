part of '../book_add_page.dart';

class BookAddActionBar extends StatelessWidget {
  const BookAddActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      overflowAlignment: OverflowBarAlignment.center,
      overflowSpacing: 10.0,
      children: <Widget>[
        // Pick File Button
        BlocBuilder<BookAddCubit, BookAddState>(
          buildWhen: (BookAddState previous, BookAddState current) =>
              previous.pathSet != current.pathSet,
          builder: _buildPickFileButton,
        ),

        // Submit Button
        BlocBuilder<BookAddCubit, BookAddState>(
          buildWhen: (BookAddState previous, BookAddState current) =>
              previous.pathSet != current.pathSet,
          builder: _buildSubmitButton,
        ),
      ],
    );
  }

  Widget _buildPickFileButton(BuildContext context, BookAddState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);

    if (state.isValid) {
      return IconButton(
        onPressed: cubit.pickFile,
        icon: const Icon(Icons.file_open_rounded),
        tooltip: appLocalizations.generalSelect,
      );
    } else {
      return ElevatedButton.icon(
        onPressed: cubit.pickFile,
        icon: const Icon(Icons.file_open_rounded),
        label: Text(appLocalizations.generalSelect),
        style: ElevatedButton.styleFrom(
          iconColor: colorScheme.onPrimary,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
        ),
      );
    }
  }

  Widget _buildSubmitButton(BuildContext context, BookAddState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);

    if (state.isValid) {
      return ElevatedButton.icon(
        onPressed: () {
          cubit.submit();

          // Return true to tell the bookshelf to refresh.
          Navigator.of(context).pop(true);
        },
        icon: const Icon(Icons.send_rounded),
        label: Text(appLocalizations.generalSubmit),
        style: ElevatedButton.styleFrom(
          iconColor: colorScheme.onPrimary,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
        ),
      );
    } else {
      return IconButton(
        onPressed: null,
        icon: const Icon(Icons.send_rounded),
        tooltip: appLocalizations.generalSubmit,
        style: ElevatedButton.styleFrom(
          iconColor: colorScheme.onPrimary,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
        ),
      );
    }
  }
}
