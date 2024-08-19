import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_book_bloc.dart';

class AddBookFilePickingButton extends StatelessWidget {
  const AddBookFilePickingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBookCubit, AddBookState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: BlocProvider.of<AddBookCubit>(context).pickFile,
          icon: const Icon(Icons.file_open_rounded),
          label: Text(AppLocalizations.of(context)!.generalSelect),
          style: ElevatedButton.styleFrom(
            foregroundColor: state.file == null ? Theme.of(context).colorScheme.onPrimary : null,
            backgroundColor: state.file == null ? Theme.of(context).colorScheme.primary : null,
          ),
        );
      },
    );
  }
}