part of '../feedback_service.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Locale currentLocale = Localizations.localeOf(context);
    final List<Locale> supportedLocales =
        List<Locale>.from(LocaleServices.supportedLocales);
    final List<Widget> children = <Widget>[];

    int insertIndex = 0;
    for (int i = 0; i < supportedLocales.length; i++) {
      final Locale cur = supportedLocales[i];
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

  Widget _createListTileByLocale(BuildContext context, Locale locale) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String languageName = LocaleServices.languageNameOf(context, locale);
    return ListTile(
      onTap: () {
        launchUrl(Uri.parse(FeedbackFormUrlData.getUrlByLocale(locale)));
      },
      leading: const Icon(Icons.assignment_rounded),
      title: Text(
          '${appLocalizations.generalFeedback} ${appLocalizations.generalForm}'),
      subtitle: Text(languageName),
      trailing: const Icon(Icons.north_east_rounded),
    );
  }
}
