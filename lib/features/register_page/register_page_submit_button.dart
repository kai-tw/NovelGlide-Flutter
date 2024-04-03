import 'package:flutter/material.dart';

import '../common_components/common_form_submit_button.dart';

class RegisterPageSubmitButton extends StatelessWidget {
  const RegisterPageSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(),
    );
  }
}
