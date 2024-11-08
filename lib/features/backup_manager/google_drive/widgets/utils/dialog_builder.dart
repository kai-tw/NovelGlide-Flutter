part of '../../backup_manager_google_drive.dart';

Widget buildBackupDialog(
  BuildContext context,
  AsyncSnapshot<Object?> snapshot,
  String successLabel,
) {
  if (snapshot.hasError) {
    // Handle error state
    // Record the error log
    final logger = Logger();
    logger.e(snapshot.error);
    logger.close();

    // Show the error dialog.
    return CommonErrorDialog(content: snapshot.error.toString());
  } else {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        // Operation done. Show success dialog.
        return CommonSuccessDialog(title: Text(successLabel));

      default:
        // Show loading dialog while waiting
        return const CommonLoadingDialog(
          title: 'Processing...',
        );
    }
  }
}
