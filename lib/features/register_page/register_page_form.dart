import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_page_bloc.dart';
import 'register_page_confirm_password_field.dart';
import 'register_page_email_field.dart';
import 'register_page_error_message.dart';
import 'register_page_title.dart';
import 'register_page_password_field.dart';
import 'register_page_submit_button.dart';

class RegisterPageForm extends StatelessWidget {
  const RegisterPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterPageCubit(),
      child: const Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RegisterPageTitle(),
              Padding(padding: EdgeInsets.only(bottom: 48.0)),
              RegisterPageErrorMessage(),
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
    );
  }
}