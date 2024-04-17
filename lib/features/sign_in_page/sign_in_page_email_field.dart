import 'package:flutter/material.dart';

import '../common_components/common_form_components/common_email_field.dart';
import 'bloc/sign_in_page_bloc.dart';

class LoginPageEmailField extends StatelessWidget {
  const LoginPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = SignInPageCubit();

    return CommonEmailField(
      isRequired: true,
      onSaved: (value) => cubit.emailAddress = value,
    );
  }
}
