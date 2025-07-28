part of '../../../book_service.dart';

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
              previous.itemState != current.itemState,
          builder: _buildPickFileButton,
        ),

        // Submit Button
        BlocBuilder<BookAddCubit, BookAddState>(
          buildWhen: (BookAddState previous, BookAddState current) =>
              previous.itemState != current.itemState,
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

    if (state.isValid) {
      return ElevatedButton.icon(
        onPressed: () => _onSubmitPressed(context),
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

  Future<void> _onSubmitPressed(BuildContext context) async {
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        cubit.submit().then((_) {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });
        return const PopScope(
          canPop: false,
          child: CommonLoadingDialog(),
        );
      },
    );

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
