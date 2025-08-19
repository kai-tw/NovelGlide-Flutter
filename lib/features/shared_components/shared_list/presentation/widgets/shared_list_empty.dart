part of '../../shared_list.dart';

class SharedListEmpty extends StatelessWidget {
  const SharedListEmpty({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RandomShockEmoticonText(
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
