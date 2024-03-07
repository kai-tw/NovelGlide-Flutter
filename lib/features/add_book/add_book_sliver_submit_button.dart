import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'bloc/add_book_form_bloc.dart';

class AddBookSliverSubmitButton extends StatelessWidget {
  const AddBookSliverSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          icon: const Icon(Icons.send_rounded),
          label: Text(
            AppLocalizations.of(context)!.submit,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
            if (Form.of(context).validate()) {
              showDialog(context: context, barrierDismissible: false, builder: _processingDialog);
              BlocProvider.of<AddBookFormCubit>(context).submit().then((bool isSuccess) {
                Navigator.of(context).pop();
                showDialog(context: context, builder: isSuccess ? _successDialog : _failedDialog)
                    .then((_) => Navigator.of(context).pop());
              });
            }
          },
        ),
      ),
    );
  }

  AlertDialog _processingDialog(BuildContext context) {
    return AlertDialog(
      icon: LoadingAnimationWidget.beat(
        color: Theme.of(context).colorScheme.secondary,
        size: 40.0,
      ),
      content: Text(
        AppLocalizations.of(context)!.processing,
        textAlign: TextAlign.center,
      ),
    );
  }

  AlertDialog _successDialog(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.check_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.secondary,
      content: Text(
        AppLocalizations.of(context)!.add_successful,
        textAlign: TextAlign.center,
      ),
    );
  }

  AlertDialog _failedDialog(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.error,
      content: Text(
        AppLocalizations.of(context)!.add_failed,
        textAlign: TextAlign.center,
      ),
    );
  }
}