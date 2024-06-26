import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_center_info_cta_body.dart';
import 'account_page_body.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.titleAccountPage),
      ),
      body: user == null
          ? CommonCenterInfoCTABody(
              content: appLocalizations.notSignedInMessage,
              actionText: appLocalizations.goToLoginPage,
              onPressed: () => Navigator.of(context).pushReplacementNamed("/sign_in"),
            )
          : const AccountPageBody(),
    );
  }
}
