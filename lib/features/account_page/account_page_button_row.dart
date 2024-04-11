import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_processing_dialog.dart';

class AccountPageButtonRow extends StatelessWidget {
  const AccountPageButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_rounded),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            color: Theme.of(context).colorScheme.error,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil(ModalRoute.withName("/"));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.signOutSuccessfully),
              ));
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ),
      ],
    );
  }
}
