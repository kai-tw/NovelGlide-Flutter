import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_page_bloc.dart';
import 'login_page_call_to_register_text.dart';
import 'login_page_email_field.dart';
import 'login_page_title.dart';
import 'login_page_password_field.dart';
import 'login_page_submit_button.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginPageCubit(),
      child: const Form(
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
    );
  }
}