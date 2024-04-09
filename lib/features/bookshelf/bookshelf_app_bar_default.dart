import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../login_page/login_page.dart';

class BookshelfAppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBarDefault({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
        },
        icon: const Icon(Icons.person),
      ),
      title: Text(AppLocalizations.of(context)!.titleBookshelf),
    );
  }
}
