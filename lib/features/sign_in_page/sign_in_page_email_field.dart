import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_email_field.dart';
import 'bloc/sign_in_page_bloc.dart';

class SignInPageEmailField extends StatelessWidget {
  const SignInPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = BlocProvider.of<SignInPageCubit>(context);

    return CommonEmailField(
      isRequired: true,
      onSaved: (value) => cubit.setEmail(value),
    );
  }
}
