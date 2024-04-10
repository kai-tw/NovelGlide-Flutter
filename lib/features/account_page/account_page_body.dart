import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'account_page_title.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    debugPrint(user.toString());
    return const SingleChildScrollView(
      child: Column(
        children: [
          AccountPageTitle(),
        ],
      ),
    );
  }
}