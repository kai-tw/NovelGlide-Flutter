import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../toolbox/verify_utility.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  String? emailAddress;
  String? password;

  LoginPageCubit() : super(const LoginPageState());

  LoginPageEmailCode emailValidator(String? email) {
    if (email == null || email == '') {
      return LoginPageEmailCode.blank;
    }

    if (!EmailValidator.validate(email)) {
      return LoginPageEmailCode.invalid;
    }

    return LoginPageEmailCode.normal;
  }

  LoginPagePasswordCode passwordValidator(String? password) {
    if (password == null || password == '') {
      return LoginPagePasswordCode.blank;
    }

    if (!VerifyUtility.passwordAllowRegex.hasMatch(password)) {
      return LoginPagePasswordCode.invalid;
    }

    return LoginPagePasswordCode.normal;
  }

  Future<bool> submit() async {
    emit(LoginPageState(code: LoginPageStateCode.normal, emailAddress: emailAddress));
    try {
      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      print(credential);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          emit(state.copyWith(code: LoginPageStateCode.wrongPassword));
          break;

        case 'user-not-found':
          emit(state.copyWith(code: LoginPageStateCode.userNotFound));
          break;
      }
      return false;
    }
    return true;
  }
}

class LoginPageState extends Equatable {
  final LoginPageStateCode code;
  final String? emailAddress;

  @override
  List<Object?> get props => [code, emailAddress];

  const LoginPageState({
    this.code = LoginPageStateCode.normal,
    this.emailAddress,
  });

  LoginPageState copyWith({
    LoginPageStateCode? code,
    String? emailAddress,
  }) {
    return LoginPageState(
      code: code ?? this.code,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
}

enum LoginPageStateCode { normal, wrongPassword, userNotFound }

enum LoginPageEmailCode { blank, invalid, normal }

enum LoginPagePasswordCode { blank, invalid, normal }
