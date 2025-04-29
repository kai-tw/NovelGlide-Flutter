import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../enum/window_class.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../../utils/file_utils.dart';
import '../../../common_components/common_back_button.dart';
import '../../data/repository/book_repository.dart';
import 'cubit/cubit.dart';

part 'widgets/form.dart';
part 'widgets/helper_text.dart';
part 'widgets/info_tile.dart';
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
          children: <Widget>[
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
