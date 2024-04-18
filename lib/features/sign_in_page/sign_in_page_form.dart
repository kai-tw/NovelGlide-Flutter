import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_page_bloc.dart';
import 'sign_in_page_call_to_register_text.dart';
import 'sign_in_page_email_field.dart';
import 'sign_in_page_password_field.dart';
import 'sign_in_page_title.dart';
import 'sign_in_page_submit_button.dart';

class SignInPageForm extends StatelessWidget {
  const SignInPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInPageCubit(),
      child: const Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 48.0),
                child: SignInPageTitle(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: SignInPageEmailField(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: SignInPagePasswordField(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: SignInPageCallToRegisterText(),
              ),
              SignInPageSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
