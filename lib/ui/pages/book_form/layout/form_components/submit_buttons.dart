import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';

class BookFormSubmitButton extends StatelessWidget {
  const BookFormSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BookFormState state = BlocProvider.of<BookFormCubit>(context).state;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (Form.of(context).validate()) {
            Form.of(context).save();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.processing)),
            );
            BlocProvider.of<BookFormCubit>(context).submitData().then((isSuccessful) {
              String message = isSuccessful
                  ? AppLocalizations.of(context)!.add_successful
                  : AppLocalizations.of(context)!.add_failed;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              Navigator.of(context).pop();
            });
          }
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary),
        child: Text(
          AppLocalizations.of(context)!.submit,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
