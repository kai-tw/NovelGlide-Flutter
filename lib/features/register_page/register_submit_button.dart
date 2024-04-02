import 'package:flutter/material.dart';

import '../common_components/common_form_submit_button.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(),
    );
  }
}
