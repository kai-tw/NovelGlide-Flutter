import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/add_book_bloc.dart';
import 'widgets/add_book_file_info_widget.dart';
import 'widgets/add_book_file_picking_button.dart';
import 'widgets/add_book_submit_button.dart';

class AddBookForm extends StatelessWidget {
  const AddBookForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48.0),
            child: BlocProvider(
              create: (context) => AddBookCubit(),
              child: Column(
                children: [
                  const AddBookFileInfoWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Text('${AppLocalizations.of(context)!.fileTypeHelperText} epub'),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddBookFilePickingButton(),
                      AddBookSubmitButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
