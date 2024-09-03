import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/book_add_bloc.dart';
import 'widgets/book_add_file_info_widget.dart';
import 'widgets/book_add_file_picking_button.dart';
import 'widgets/book_add_submit_button.dart';

class BookAddForm extends StatelessWidget {
  const BookAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24.0),
            child: BlocProvider(
              create: (context) => BookAddCubit(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BookAddFileInfoWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Text('${AppLocalizations.of(context)!.fileTypeHelperText} epub'),
                  ),
                  const OverflowBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    overflowAlignment: OverflowBarAlignment.center,
                    overflowSpacing: 10.0,
                    children: [
                      BookAddFilePickingButton(),
                      BookAddSubmitButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: 4.0,
          right: 4.0,
          child: CommonBackButton(iconData: Icons.close_rounded),
        ),
      ],
    );
  }
}
