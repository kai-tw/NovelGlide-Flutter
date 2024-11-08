part of '../backup_manager_google_drive.dart';

class _BackupBookProcessDialog extends StatelessWidget {
  const _BackupBookProcessDialog();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _BackupBookProcessCubit(),
      child: BlocBuilder<_BackupBookProcessCubit, _ProcessDialogState>(
        builder: (context, state) {
          switch (state.step) {
            case _ProcessStep.archive:
              return CommonLoadingDialog(
                // TODO: Localize this
                title: 'Archiving books...',
                progress: state.progress,
              );

            case _ProcessStep.upload:
              return CommonLoadingDialog(
                // TODO: Localize this
                title: 'Uploading books...',
                progress: state.progress,
              );

            case _ProcessStep.done:
              return const CommonSuccessDialog();
          }
        },
      ),
    );
  }
}
