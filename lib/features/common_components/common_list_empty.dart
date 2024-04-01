import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/emoticon_collection.dart';

class CommonListEmpty extends StatelessWidget {
  const CommonListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
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

class CommonSliverListEmpty extends StatelessWidget {
  const CommonSliverListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: CommonListEmpty(),
    );
  }
}
