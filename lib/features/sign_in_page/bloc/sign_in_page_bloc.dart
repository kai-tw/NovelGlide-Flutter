import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/auth_services.dart';
import '../../../toolbox/verify_utility.dart';

class SignInPageCubit extends Cubit<SignInPageState> {
  String? emailAddress;
  String? password;

  SignInPageCubit() : super(const SignInPageState());

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
    emit(SignInPageState(code: SignInPageStateCode.normal, emailAddress: emailAddress));
    try {
      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      AuthServices.instance.setCredential(credential);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          emit(state.copyWith(code: SignInPageStateCode.wrongPassword));
          break;

        case 'user-not-found':
          emit(state.copyWith(code: SignInPageStateCode.userNotFound));
          break;
      }
      return false;
    }
    return true;
  }
}

class SignInPageState extends Equatable {
  final SignInPageStateCode code;
  final String? emailAddress;

  @override
  List<Object?> get props => [code, emailAddress];

  const SignInPageState({
    this.code = SignInPageStateCode.normal,
    this.emailAddress,
  });

  SignInPageState copyWith({
    SignInPageStateCode? code,
    String? emailAddress,
  }) {
    return SignInPageState(
      code: code ?? this.code,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
}

enum SignInPageStateCode { normal, wrongPassword, userNotFound }

enum SignInPageEmailCode { blank, invalid, normal }

enum SignInPagePasswordCode { blank, invalid, normal }
