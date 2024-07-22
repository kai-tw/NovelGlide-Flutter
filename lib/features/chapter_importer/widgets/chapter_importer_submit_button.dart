import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../processor/chapter_processor_exception.dart';
import '../../common_components/common_form_submit_button.dart';
import '../bloc/chapter_importer_bloc.dart';

class ChapterImporterSubmitButton extends StatelessWidget {
  const ChapterImporterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return CommonFormSubmitButton(
      onPressed: BlocProvider.of<ChapterImporterCubit>(context).submit,
      onSuccess: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(appLocalizations.importSuccessfully),
        ));
      },
      onFailed: (e) {
        String message = appLocalizations.importFailed;

        if (e is ChapterProcessorDuplicateException) {
          String text = e.number.toString();
          switch (appLocalizations.localeName) {
            case "en":
              text += e.number % 10 == 1 ? "st" : e.number % 10 == 2 ? "nd" : e.number % 10 == 3 ? "rd" : "th";
              break;
          }
          message = appLocalizations.exceptionChapterProcessorDuplicate(text);
        }

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            iconColor: Theme.of(context).colorScheme.error,
            icon: const Icon(Icons.error_outline_rounded, size: 48.0),
            title: Text(appLocalizations.importFailed),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(appLocalizations.close),
              ),
            ],
          ),
        );
      },
    );
  }
}
