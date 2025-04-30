part of '../book_add_dialog.dart';

class BookAddDialogActionBar extends StatelessWidget {
  const BookAddDialogActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return OverflowBar(
      alignment: MainAxisAlignment.spaceBetween,
      overflowAlignment: OverflowBarAlignment.center,
      overflowSpacing: 10.0,
      children: <Widget>[
        // Close Button
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          tooltip: appLocalizations.generalClose,
        ),

        // Pick File Button
        BlocBuilder<BookAddCubit, BookAddState>(
          buildWhen: (BookAddState previous, BookAddState current) =>
              previous.file != current.file,
          builder: _buildPickFileButton,
        ),

        // Submit Button
        BlocBuilder<BookAddCubit, BookAddState>(
          buildWhen: (BookAddState previous, BookAddState current) =>
              previous.file != current.file,
          builder: _buildSubmitButton,
        ),
      ],
    );
  }

  Widget _buildPickFileButton(BuildContext context, BookAddState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);

    return ElevatedButton.icon(
      onPressed: cubit.pickFile,
      icon: const Icon(Icons.file_open_rounded),
      label: Text(appLocalizations.generalSelect),
      style: ElevatedButton.styleFrom(
        iconColor: state.isValid ? null : colorScheme.onPrimary,
        foregroundColor: state.isValid ? null : colorScheme.onPrimary,
        backgroundColor: state.isValid ? null : colorScheme.primary,
      ),
    );
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
