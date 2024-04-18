import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPageCubit extends Cubit<SignInPageState>{
  String? _emailAddress;
  String? _password;
  FirebaseException? exception;

  SignInPageCubit() : super(const SignInPageState());

  void setEmail(String? value) {
    _emailAddress = value;
  }

  void setPassword(String? value) {
    _password = value;
  }

  Future<bool> submit() async {
    if (_emailAddress == null || _password == null) {
      return false;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailAddress!,
        password: _password!,
      );
    } on FirebaseException catch (e) {
      exception = e;
      return false;
    }
    exception = null;
    return true;
  }
}

class SignInPageState extends Equatable {
  @override
  List<Object?> get props => [];

  const SignInPageState();
}