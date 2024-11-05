part of '../backup_manager_google_drive.dart';

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_Cubit>(context);
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          title: Text(appLocalizations.backupManagerGoogleDrive),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == LoadingStateCode.loaded,
          onChanged: (value) {
            if (state.code == LoadingStateCode.loading) {
              return;
            }

            cubit.setEnabled(value).then((_) {
              cubit.refresh();
            }).catchError((err) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) => CommonErrorDialog(
                    content: err.toString(),
                  ),
                );
              }
            });
          },
        );
      },
    );
  }
}
