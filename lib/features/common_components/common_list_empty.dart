import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/emoticon_collection.dart';

class CommonListEmpty extends StatelessWidget {
  const CommonListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                EmoticonCollection.getRandomShock(),
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),
            Text(AppLocalizations.of(context)!.generalEmpty),
          ],
        ),
      ),
    );
  }
}

class CommonSliverListEmpty extends StatelessWidget {
  const CommonSliverListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: CommonListEmpty(),
    );
  }
}
