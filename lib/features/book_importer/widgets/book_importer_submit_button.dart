import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_form_components/common_form_submit_button.dart';
import '../bloc/book_importer_bloc.dart';

class BookImporterSubmitButton extends StatelessWidget {
  const BookImporterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BookImporterCubit cubit = BlocProvider.of<BookImporterCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return CommonFormSubmitButton(
      onPressed: cubit.submit,
      onSuccess: () => Navigator.of(context).pop(true),
      onFailed: (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(appLocalizations.importWhatFailed(appLocalizations.book)),
        ));
      },
    );
  }
}