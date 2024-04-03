import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'register_page_confirm_password_field.dart';
import 'register_page_email_field.dart';
import 'register_page_title.dart';
import 'register_page_password_field.dart';
import 'register_page_submit_button.dart';

class RegisterPageScaffold extends StatelessWidget {
  const RegisterPageScaffold({super.key});

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
                RegisterPageTitle(),
                Padding(padding: EdgeInsets.only(bottom: 48.0)),
                RegisterPageEmailField(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                RegisterPagePasswordField(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                RegisterPageConfirmPasswordField(),
                Padding(padding: EdgeInsets.only(bottom: 24.0)),
                RegisterPageSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}