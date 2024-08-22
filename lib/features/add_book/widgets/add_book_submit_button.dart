import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_book_bloc.dart';

class AddBookSubmitButton extends StatelessWidget {
  const AddBookSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookCubit cubit = BlocProvider.of<AddBookCubit>(context);
    return BlocBuilder<AddBookCubit, AddBookState>(
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

  void _onPressed(BuildContext context, AddBookCubit cubit) {
    cubit.submit().then((_) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }).catchError((e) {
      if (e is AddBookDuplicateFileException && context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: Icon(
              Icons.error_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(AppLocalizations.of(context)!.addBookFailed),
            content: Text(AppLocalizations.of(context)!.addBookDuplicated),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.generalClose),
              ),
            ],
          ),
        );
      }
    });
  }
}
