import 'package:flutter/material.dart';

import '../../../features/shared_components/common_error_widgets/common_error_dialog.dart';

part 'exceptions/google_drive_permission_exception.dart';
part 'exceptions/google_sign_in_exception.dart';

class ExceptionService {
  const ExceptionService._();

  static Future<void> showExceptionDialog({
    required BuildContext context,
    required String contents,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonErrorDialog(content: contents);
      },
    );
  }
}
