import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../locale_system/domain/entities/app_locale.dart';
import '../../locale_system/locale_utils.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final AppLocale currentLocale =
        LocaleUtils.convertLocaleToAppLocale(Localizations.localeOf(context));
    final List<AppLocale> supportedLocales = LocaleUtils.supportedLocales;
    final List<Widget> children = <Widget>[];

    int insertIndex = 0;
    for (int i = 0; i < supportedLocales.length; i++) {
      final AppLocale cur = supportedLocales[i];
      if (cur == currentLocale) {
        children.insert(0, _createListTileByLocale(context, cur));
        insertIndex++;
      } else if (cur.languageCode == currentLocale.languageCode) {
        children.insert(insertIndex, _createListTileByLocale(context, cur));
      } else {
        children.add(_createListTileByLocale(context, cur));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.generalFeedback),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _createListTileByLocale(BuildContext context, AppLocale appLocale) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String languageName = LocaleUtils.languageNameOf(context, appLocale);
    return ListTile(
      onTap: () {
        launchUrl(Uri.parse(_getUrlByLocale(appLocale)));
      },
      leading: const Icon(Icons.assignment_rounded),
      title: Text(
          '${appLocalizations.generalFeedback} ${appLocalizations.generalForm}'),
      subtitle: Text(languageName),
      trailing: const Icon(Icons.north_east_rounded),
    );
  }

  String _getUrlByLocale(AppLocale locale) {
    final String id = switch (locale) {
      const AppLocale('en') =>
        '1FAIpQLScMbqxt1GTgz3-VyGpSk8avoPgWxvB9crIFvgdYrGZYbtE2zg',
      const AppLocale('zh') =>
        '1FAIpQLSdo77Am6qvaoIz9K9FWmySt21p9VnLiikUv0KfxWKV1jf01jQ',
      const AppLocale('zh', 'Hans', 'CN') =>
        '1FAIpQLSdlDoVsZdyt9GBEivAUxNcv7ohDOKaEv5OornD-DMTxiQWm7g',
      const AppLocale('ja') =>
        '1FAIpQLSeibENYH3G57PWw28pawmnJF_rMtzrr-3QbQpiuhF6W6HfLnw',
      _ => '',
    };
    return id.isEmpty ? '' : 'https://docs.google.com/forms/d/e/$id/viewform';
  }
}
