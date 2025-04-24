part of '../developer_page.dart';

class _BackupProgressDialog extends StatefulWidget {
  const _BackupProgressDialog();

  @override
  State<_BackupProgressDialog> createState() => _BackupProgressDialogState();
}

class _BackupProgressDialogState extends State<_BackupProgressDialog> {
  double progress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _process());
  }

  @override
  Widget build(BuildContext context) {
    if (progress < 1) {
      return CommonLoadingDialog(
        title: 'Archiving books...',
        progress: progress,
      );
    } else {
      return const CommonSuccessDialog();
    }
  }

  Future<void> _process() async {
    for (int i = 0; i <= 100; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      setState(() => progress = i / 100);
    }
  }
}
