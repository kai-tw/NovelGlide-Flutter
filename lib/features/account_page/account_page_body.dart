import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'account_page_button_row.dart';
import 'account_page_greeting.dart';
import 'account_page_info_row.dart';
import 'account_page_photo.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    debugPrint(user.toString());
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const AccountPagePhoto(),
              const AccountPageGreeting(),
              AccountPageInfoRow(
                iconData: Icons.alternate_email_rounded,
                content: user?.email,
              ),
              AccountPageInfoRow(
                iconData: Icons.phone_rounded,
                content: user?.phoneNumber,
              ),
              const AccountPageButtonRow(),
            ],
          ),
        ),
      ),
    );
  }
}
