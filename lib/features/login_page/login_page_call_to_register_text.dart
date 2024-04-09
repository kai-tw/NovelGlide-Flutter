import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPageCallToRegisterText extends StatelessWidget {
  const LoginPageCallToRegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Color registerTextColor = Theme.of(context).colorScheme.tertiary;

    return Text.rich(
      TextSpan(
        text: appLocalizations.noAccountGoRegister,
        children: [
          TextSpan(
            text: appLocalizations.register,
            recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pushNamed("/register"),
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: registerTextColor,
              color: registerTextColor,
            ),
          )
        ]
      ),
    );
  }
}
