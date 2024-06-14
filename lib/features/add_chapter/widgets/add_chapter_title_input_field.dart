import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_chapter_form_bloc.dart';

class AddChapterTitleInputField extends StatelessWidget {
  const AddChapterTitleInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChapterFormCubit cubit = BlocProvider.of<AddChapterFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.fieldChapterName + appLocalizations.fieldOptional,
      ),
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      onSaved: (value) => cubit.title = value,
    );
  }
}
