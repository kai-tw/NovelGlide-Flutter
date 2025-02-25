import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../enum/window_class.dart';
import '../../exceptions/file_exceptions.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../repository/book_repository.dart';
import '../../utils/file_utils.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_error_dialog.dart';

part 'bloc/cubit.dart';
part 'dialog/file_duplicate_error_dialog.dart';
part 'widgets/file_info_list_tile.dart';
part 'widgets/form.dart';
part 'widgets/form_file_helper_text.dart';
part 'widgets/pick_file_button.dart';
part 'widgets/submit_button.dart';

class BookAddDialog extends StatelessWidget {
  const BookAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: const Stack(
          children: [
            _Form(),
            Positioned(
              top: 4.0,
              right: 4.0,
              child: CommonBackButton(iconData: Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
