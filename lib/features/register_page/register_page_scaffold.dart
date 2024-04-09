import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'register_page_form.dart';

class RegisterPageScaffold extends StatelessWidget {
  const RegisterPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = const Padding(
      padding: EdgeInsets.all(24.0),
      child: RegisterPageForm(),
    );

    if (FirebaseAuth.instance.currentUser != null) {
      body = const Center(
        child: Text("You have signed in."),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: body,
    );
  }
}