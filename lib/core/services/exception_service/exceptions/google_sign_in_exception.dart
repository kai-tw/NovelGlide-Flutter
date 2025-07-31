part of '../exception_service.dart';

class GoogleAuthSignInException implements Exception {
  GoogleAuthSignInException({
    this.message = 'google_sign_in_failed',
  });

  final String message;
}
