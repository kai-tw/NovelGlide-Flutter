part of '../backup_manager_google_drive.dart';

class _TimeListTile extends StatelessWidget {
  const _TimeListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isLoading = state.code == LoadingStateCode.loading;
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
          leading: const Icon(Icons.calendar_today_rounded),
          title: Text(appLocalizations.backupManagerLastTime),
          subtitle: Text(
            DateTimeUtils.format(
              state.lastBackupTime,
              defaultValue: '-',
            ),
          ),
          trailing: isLoading ? const CircularProgressIndicator() : null,
        );
      },
    );
  }
}
