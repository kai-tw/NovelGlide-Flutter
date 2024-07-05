import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_center_info_cta_body.dart';
import 'register_page_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: user == null
          ? CommonCenterInfoCTABody(
        content: appLocalizations.alreadySignedInMessage,
        actionText: appLocalizations.goToAccountPage,
        onPressed: () => Navigator.of(context).pushReplacementNamed("/account"),
      )
          : const Padding(
        padding: EdgeInsets.all(24.0),
        child: RegisterPageForm(),
      ),
    );
  }
}
