import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookshelfAppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBarDefault({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          final User? user = FirebaseAuth.instance.currentUser;
          Navigator.of(context).pushNamed(user != null ? "/account" : "/sign_in");
        },
        icon: const Icon(Icons.person),
      ),
      title: Text(AppLocalizations.of(context)!.titleBookshelf),
    );
  }
}
