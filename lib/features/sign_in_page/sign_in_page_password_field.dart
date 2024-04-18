import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_form_components/common_password_field.dart';
import 'bloc/sign_in_page_bloc.dart';

class SignInPagePasswordField extends StatelessWidget {
  const SignInPagePasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = BlocProvider.of<SignInPageCubit>(context);

    return CommonPasswordField(
      isRequired: true,
      onSaved: (value) => cubit.setPassword(value),
    );
  }
}
