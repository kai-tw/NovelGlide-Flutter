import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookshelfSliverAppBarDefault extends StatelessWidget {
  const BookshelfSliverAppBarDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
      ),
      title: Text(AppLocalizations.of(context)!.app_name),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
    );
  }
}