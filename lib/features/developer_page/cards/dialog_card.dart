part of '../developer_page.dart';

class _DialogCard extends StatelessWidget {
  const _DialogCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('Dialog'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CommonSuccessDialog(),
          ),
          title: const Text('Success Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CommonLoadingDialog(
              title: 'Loading Dialog',
            ),
          ),
          title: const Text('Loading Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CommonLoadingDialog(
              title: 'Progress Dialog',
              progress: 0.6,
            ),
          ),
          title: const Text('Progress Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CommonDeleteDialog(),
          ),
          title: const Text('Delete Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CommonErrorDialog(
              title: 'Error Dialog',
              content: 'Error Dialog',
            ),
          ),
          title: const Text('Error Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              content: CommonErrorWidget(),
            ),
          ),
          title: const Text('Error Widget'),
        ),
      ],
    );
  }
}
