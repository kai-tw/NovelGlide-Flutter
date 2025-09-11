import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';

import '../../../../generated/i18n/app_localizations.dart';

class ExploreManual extends StatelessWidget {
  const ExploreManual({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.exploreManual),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: MarkdownWidget(
            data: '# What\'s Discovery?\n\n'
                'The discovery system can help you to view catalogs on web, '
                'and download books directly into your bookshelf.',
          ),
        ),
      ),
    );
  }
}
