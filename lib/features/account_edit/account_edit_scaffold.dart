import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_center_info_cta_body.dart';
import 'account_edit_normal_form.dart';

class AccountEditScaffold extends StatelessWidget {
  const AccountEditScaffold({super.key});

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
              content: appLocalizations.notSignedInMessage,
              actionText: appLocalizations.goToLoginPage,
              onPressed: () => Navigator.of(context).pushReplacementNamed("/sign_in"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        appLocalizations.accountEditGeneral,
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    const AccountEditNormalForm(),
                  ],
                ),
              ),
            ),
    );
  }
}
