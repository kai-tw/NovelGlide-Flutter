import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_form_submit_button.dart';
import '../bloc/chapter_importer_bloc.dart';

class ChapterImporterSubmitButton extends StatelessWidget {
  const ChapterImporterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonFormSubmitButton(
      onPressed: BlocProvider.of<ChapterImporterCubit>(context).submit,
      onSuccess: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.importSuccessfully),
        ));
      },
      onFailed: (_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.importFailed),
        ));
      },
    );
  }
}