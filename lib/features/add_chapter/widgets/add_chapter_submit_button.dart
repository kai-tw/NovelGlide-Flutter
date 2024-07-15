import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_form_submit_button.dart';
import '../bloc/add_chapter_form_bloc.dart';

class AddChapterSubmitButton extends StatelessWidget {
  const AddChapterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(
        onPressed: BlocProvider.of<AddChapterFormCubit>(context).submit,
        onSuccess: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.addChapterSuccessfully),
          ));
        },
        onFailed: (_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.addChapterFailed),
          ));
        },
      ),
    );
  }
}