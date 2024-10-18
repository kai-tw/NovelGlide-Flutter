import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import '../common_components/common_back_button.dart';
import 'bloc/book_add_bloc.dart';
import 'widgets/book_add_file_info_widget.dart';
import 'widgets/book_add_file_picking_button.dart';
import 'widgets/book_add_submit_button.dart';

class BookAddDialog extends StatelessWidget {
  const BookAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: Stack(
          children: [
            _buildForm(context),
            _buildCloseButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the form with file info, helper text, and action buttons.
  Widget _buildForm(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider(
          create: (context) => BookAddCubit(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BookAddFileInfoWidget(),
              _buildHelperText(context),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the helper text for file type.
  Widget _buildHelperText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Text('${AppLocalizations.of(context)!.fileTypeHelperText} epub'),
    );
  }

  /// Builds the action buttons for file picking and submission.
  Widget _buildActionButtons() {
    return const OverflowBar(
      alignment: MainAxisAlignment.spaceBetween,
      overflowAlignment: OverflowBarAlignment.center,
      overflowSpacing: 10.0,
      children: [
        BookAddFilePickingButton(),
        BookAddSubmitButton(),
      ],
    );
  }

  /// Builds the close button positioned at the top-right corner.
  Widget _buildCloseButton() {
    return const Positioned(
      top: 4.0,
      right: 4.0,
      child: CommonBackButton(iconData: Icons.close_rounded),
    );
  }
}
