import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/auth_services.dart';
import '../../../toolbox/verify_utility.dart';

class SignInPageCubit {
  static final SignInPageCubit instance = SignInPageCubit._init();
  String? emailAddress;
  String? password;
  FirebaseException? exception;

  factory SignInPageCubit() {
    return instance;
  }

  SignInPageCubit._init();

  SignInPageEmailCode emailValidator(String? email) {
    if (email == null || email == '') {
      return SignInPageEmailCode.blank;
    }

    if (!EmailValidator.validate(email)) {
      return SignInPageEmailCode.invalid;
    }

    return SignInPageEmailCode.normal;
  }

  SignInPagePasswordCode passwordValidator(String? password) {
    if (password == null || password == '') {
      return SignInPagePasswordCode.blank;
    }

    if (!VerifyUtility.passwordAllowRegex.hasMatch(password)) {
      return SignInPagePasswordCode.invalid;
    }

    return SignInPagePasswordCode.normal;
  }

  Future<bool> submit() async {
    try {
      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      AuthServices.instance.setCredential(credential);
    } on FirebaseException catch (e) {
      exception = e;
      return false;
    }
    exception = null;
    return true;
  }
}

enum SignInPageStateCode { normal, wrongPassword, userNotFound }

enum SignInPageEmailCode { blank, invalid, normal }

enum SignInPagePasswordCode { blank, invalid, normal }
