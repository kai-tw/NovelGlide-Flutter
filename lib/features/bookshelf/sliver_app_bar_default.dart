import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookshelfSliverAppBarDefault extends StatelessWidget {
  const BookshelfSliverAppBarDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(AppLocalizations.of(context)!.app_name),
      ),
    );
  }
}