import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../toolbox/emoticon_collection.dart';

class StoreUnavailableText extends StatelessWidget {
  const StoreUnavailableText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              EmoticonCollection.getRandomShock(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(AppLocalizations.of(context)!.storeUnavailable),
        ],
      ),
    );
  }
}