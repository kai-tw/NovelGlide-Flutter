import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../register_page/register_page.dart';

class BookshelfAppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBarDefault({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterPage()));
        },
        icon: const Icon(Icons.person),
      ),
      title: Text(AppLocalizations.of(context)!.titleBookshelf),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
    );
  }
}
