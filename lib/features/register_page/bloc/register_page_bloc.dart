import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../toolbox/verify_utility.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  String? emailAddress;
  String? password;
  String? inputPassword;

  RegisterPageCubit() : super(const RegisterPageState());

  RegisterPageEmailCode emailValidator(String? email) {
    if (email == null || email == '') {
      return RegisterPageEmailCode.blank;
    }

    if (!EmailValidator.validate(email)) {
      return RegisterPageEmailCode.invalid;
    }

    return RegisterPageEmailCode.normal;
  }

  RegisterPagePasswordCode passwordValidator(String? password) {
    inputPassword = password;
    if (password == null || password == '') {
      return RegisterPagePasswordCode.blank;
    }

    if (!VerifyUtility.passwordAllowRegex.hasMatch(password)) {
      return RegisterPagePasswordCode.invalid;
    }

    return RegisterPagePasswordCode.normal;
  }

  Future<bool> submit() async {
    emit(RegisterPageState(code: RegisterPageStateCode.normal, emailAddress: emailAddress));
    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'weak-password':
          emit(state.copyWith(code: RegisterPageStateCode.weakPassword));
          break;

        case 'email-already-in-use':
          emit(state.copyWith(code: RegisterPageStateCode.emailUsed));
          break;
      }
      return false;
    }
    return true;
  }
}

class RegisterPageState extends Equatable {
  final RegisterPageStateCode code;
  final String? emailAddress;

  @override
  List<Object?> get props => [code, emailAddress];

  const RegisterPageState({
    this.code = RegisterPageStateCode.normal,
    this.emailAddress,
  });

  RegisterPageState copyWith({
    RegisterPageStateCode? code,
    String? emailAddress,
  }) {
    return RegisterPageState(
      code: code ?? this.code,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
}

enum RegisterPageStateCode { normal, weakPassword, emailUsed }

enum RegisterPageEmailCode { blank, invalid, normal }

enum RegisterPagePasswordCode { blank, invalid, normal }
