part of '../developer_page.dart';

class _DialogCard extends StatelessWidget {
  const _DialogCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: [
        ListTile(
          title: const Text('Dialog'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const CommonSuccessDialog(),
          ),
          title: const Text('Success Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const CommonLoadingDialog(
              title: 'Loading Dialog',
            ),
          ),
          title: const Text('Loading Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const CommonLoadingDialog(
              title: 'Progress Dialog',
              progress: 0.6,
            ),
          ),
          title: const Text('Progress Dialog'),
        ),
        ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const CommonErrorDialog(
              content: 'Error Dialog',
            ),
          ),
          title: const Text('Error Dialog'),
        ),
      ],
    );
  }
}
