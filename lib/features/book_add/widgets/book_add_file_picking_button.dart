import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_add_bloc.dart';

class BookAddFilePickingButton extends StatelessWidget {
  const BookAddFilePickingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: BlocProvider.of<BookAddCubit>(context).pickFile,
          icon: const Icon(Icons.file_open_rounded),
          label: Text(appLocalizations?.generalSelect ?? 'Select'),
          style: ElevatedButton.styleFrom(
            foregroundColor: state.file == null ? colorScheme.onPrimary : null,
            backgroundColor: state.file == null ? colorScheme.primary : null,
          ),
        );
      },
    );
  }
}
