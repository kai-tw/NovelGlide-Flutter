import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  UserCredential? _credential;

  static final AuthServices instance = AuthServices._init();

  // factory AuthServices() {
  //   return instance;
  // }

  AuthServices._init();

  void setCredential(UserCredential credential) {
    _credential = credential;
  }

  UserCredential? getCredential() {
    return _credential;
  }

  @override
  String toString() {
    return "AuthServices(credential: $_credential)";
  }
}