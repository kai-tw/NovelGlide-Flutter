import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    debugPrint(user.toString());
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}