import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'register_email_field.dart';
import 'register_page_title.dart';
import 'register_password_field.dart';
import 'register_submit_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: RegisterPageTitle(),
              ),
              Padding(padding: EdgeInsets.only(bottom: 48.0)),
              RegisterEmailField(),
              Padding(padding: EdgeInsets.only(bottom: 24.0)),
              RegisterPasswordField(),
              Padding(padding: EdgeInsets.only(bottom: 24.0)),
              RegisterSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
