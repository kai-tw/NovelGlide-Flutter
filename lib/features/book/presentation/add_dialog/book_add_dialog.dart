import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../core/utils/file_utils.dart';
import '../../../../enum/window_class.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../data/repository/book_repository.dart';
import 'cubit/book_add_cubit.dart';

part 'widgets/book_add_dialog_action_bar.dart';
part 'widgets/book_add_dialog_helper_text.dart';
part 'widgets/book_add_dialog_info_tile.dart';

class BookAddDialog extends StatelessWidget {
  const BookAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: BlocProvider<BookAddCubit>(
          create: (_) => BookAddCubit(),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BookAddDialogInfoTile(),
              BookAddDialogHelperText(),
              BookAddDialogActionBar(),
            ],
          ),
        ),
      ),
    );
  }
}
