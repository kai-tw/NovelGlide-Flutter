import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        onPressed: cubit.submit,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(appLocalizations.signInSuccess)));
          Navigator.of(context).pop();
        },
        onFailed: (_) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(appLocalizations.signInFailed),
              content: Text(appLocalizations.invalidCredential),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.close),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
