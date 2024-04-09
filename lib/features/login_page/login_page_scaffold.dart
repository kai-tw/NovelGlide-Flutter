import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'login_page_call_to_register_text.dart';
import 'login_page_email_field.dart';
import 'login_page_title.dart';
import 'login_page_password_field.dart';
import 'login_page_submit_button.dart';

class LoginPageScaffold extends StatelessWidget {
  const LoginPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoginPageTitle(),
                Padding(padding: EdgeInsets.only(bottom: 48.0)),
                LoginPageEmailField(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                LoginPagePasswordField(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                LoginPageCallToRegisterText(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                LoginPageSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}