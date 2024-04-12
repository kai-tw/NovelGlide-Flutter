import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_dialog/common_dialog.dart';
import '../common_components/common_form_submit_button.dart';
import 'bloc/sign_in_page_bloc.dart';

class SignInPageSubmitButton extends StatelessWidget {
  const SignInPageSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = BlocProvider.of<SignInPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(
        onPressed: () => cubit.submit(),
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(appLocalizations.signInSuccess)));
          Navigator.of(context).pop();
        },
        onFailed: () {
          showDialog(
            context: context,
            builder: (_) => CommonDialog(
              title: appLocalizations.signInFailed,
              content: appLocalizations.invalidCredential,
            ),
          );
        },
      ),
    );
  }
}
