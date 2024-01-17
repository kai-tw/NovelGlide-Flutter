import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'emoticon_collection.dart';

class CommonSliverListEmpty extends StatelessWidget {
  const CommonSliverListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(EmoticonCollection.getRandomShock()),
          Text(AppLocalizations.of(context)!.empty),
        ],
      ),
    );
  }
}
