part of '../backup_service_process_dialog.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: <Widget>[
        BlocBuilder<BackupServiceProcessCubit, BackupServiceProcessState>(
            buildWhen: (BackupServiceProcessState previous,
                    BackupServiceProcessState current) =>
                previous.isRunning != current.isRunning,
            builder: (BuildContext context, BackupServiceProcessState state) {
              return TextButton.icon(
                onPressed:
                    state.isRunning ? null : () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
                label: Text(AppLocalizations.of(context)!.generalClose),
              );
            }),
      ],
    );
  }
}
