import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPagePhoto extends StatelessWidget {
  const AccountPagePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundImage: user != null && user.photoURL != null ? NetworkImage(user.photoURL!) : null,
          radius: 50.0,
          child: Icon(
            Icons.person_rounded,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
