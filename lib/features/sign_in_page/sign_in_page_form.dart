import 'package:flutter/material.dart';

import 'sign_in_page_call_to_register_text.dart';
import 'sign_in_page_email_field.dart';
import 'sign_in_page_title.dart';
import 'sign_in_page_password_field.dart';
import 'sign_in_page_submit_button.dart';

class SignInPageForm extends StatelessWidget {
  const SignInPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SignInPageTitle(),
            Padding(padding: EdgeInsets.only(bottom: 48.0)),
            LoginPageEmailField(),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
            SignInPagePasswordField(),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
            SignInPageCallToRegisterText(),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
            SignInPageSubmitButton(),
          ],
        ),
      ),
    );
  }
}