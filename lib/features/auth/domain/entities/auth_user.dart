import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  final String displayName;
  final String email;
  final String photoUrl;

  @override
  List<Object?> get props => <Object?>[
        displayName,
        email,
        photoUrl,
      ];
}
