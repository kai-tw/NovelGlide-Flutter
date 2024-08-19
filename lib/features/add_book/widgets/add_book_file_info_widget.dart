import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_book_bloc.dart';

class AddBookFileInfoWidget extends StatelessWidget {
  const AddBookFileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBookCubit, AddBookState>(
      buildWhen: (previous, current) =>
          previous.file != current.file ||
          previous.fileName != current.fileName ||
          previous.fileSize != current.fileSize,
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            state.fileName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(state.fileSize),
          trailing: state.file == null
              ? null
              : IconButton(
                  onPressed: BlocProvider.of<AddBookCubit>(context).removeFile,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    semanticLabel: AppLocalizations.of(context)!.generalDelete,
                  ),
                  style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Theme.of(context).colorScheme.onError,
                  ),
                ),
        );
      },
    );
  }
}
