import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../toolbox/verify_utility.dart';
import '../common_components/common_form_decoration.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration("Email"),
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.emailDenyRegex),
      ],
    );
  }
}