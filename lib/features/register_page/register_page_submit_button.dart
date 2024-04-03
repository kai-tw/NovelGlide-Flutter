import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_form_submit_button.dart';
import 'bloc/register_page_bloc.dart';

class RegisterPageSubmitButton extends StatelessWidget {
  const RegisterPageSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit cubit = BlocProvider.of<RegisterPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(
        onPressed: () => cubit.submit(),
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(appLocalizations.registerSuccess)));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
