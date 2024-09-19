import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_add_bloc.dart';

class BookAddSubmitButton extends StatelessWidget {
  const BookAddSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.file == null ? null : () => _onPressed(context, cubit),
          icon: const Icon(Icons.send_rounded),
          label: Text(AppLocalizations.of(context)!.generalSubmit),
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  void _onPressed(BuildContext context, BookAddCubit cubit) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final NavigatorState navigator = Navigator.of(context);
    final ThemeData themeData = Theme.of(context);

    cubit.submit().then((_) {
      navigator.pop(true);
    }).catchError((e) {
      if (e is AddBookDuplicateFileException && context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: Icon(
              Icons.error_rounded,
              size: 48,
              color: themeData.colorScheme.error,
            ),
            title: Text(appLocalizations.addBookFailed),
            content: Text(appLocalizations.addBookDuplicated),
            actions: [
              TextButton(
                onPressed: () => navigator.pop(),
                child: Text(appLocalizations.generalClose),
              ),
            ],
          ),
        );
      }
    });
  }
}
