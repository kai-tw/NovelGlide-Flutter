import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/emoticon_collection.dart';

class CommonListEmpty extends StatelessWidget {
  final String? title;

  const CommonListEmpty({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(title ?? appLocalizations.generalEmpty),
          ],
        ),
      ),
    );
  }
}

class CommonSliverListEmpty extends StatelessWidget {
  final String? title;

  const CommonSliverListEmpty({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: CommonListEmpty(title: title),
    );
  }
}
