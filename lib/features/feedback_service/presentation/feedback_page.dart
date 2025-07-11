part of '../feedback_service.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Locale> supportedLocales = LocaleServices.supportedLocales;

    print(LocaleServices.currentLocale);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://docs.google.com/forms/d/e/1FAIpQLSdo77Am6qvaoIz9K9FWmySt21p9VnLiikUv0KfxWKV1jf01jQ/viewform'));
              },
              leading: Icon(Icons.feedback_rounded),
              title: Text("Traditional Chinese Form"),
              trailing: Icon(Icons.north_east_rounded),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://docs.google.com/forms/d/e/1FAIpQLSdlDoVsZdyt9GBEivAUxNcv7ohDOKaEv5OornD-DMTxiQWm7g/viewform'));
              },
              leading: Icon(Icons.feedback_rounded),
              title: Text("Simplified Chinese Form"),
              trailing: Icon(Icons.north_east_rounded),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    FeedbackFormUrlData.getUrlByLocale(const Locale('en'))));
              },
              leading: Icon(Icons.feedback_rounded),
              title: Text("English Form"),
              trailing: Icon(Icons.north_east_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
