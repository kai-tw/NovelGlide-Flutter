import 'package:firebase_auth/firebase_auth.dart';

class SignInPageCubit {
  static final SignInPageCubit instance = SignInPageCubit._init();
  String? emailAddress;
  String? password;
  FirebaseException? exception;

  factory SignInPageCubit() {
    return instance;
  }

  SignInPageCubit._init();

  Future<bool> submit() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
    } on FirebaseException catch (e) {
      exception = e;
      return false;
    }
    exception = null;
    return true;
  }
}
