import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_add_bloc.dart';

class BookAddFileInfoWidget extends StatelessWidget {
  const BookAddFileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) =>
          previous.file != current.file ||
          previous.fileName != current.fileName ||
          previous.fileSize != current.fileSize,
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            state.fileName ?? appLocalizations.fileEmpty,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(state.fileName == null ? 0.7 : 1.0),
            ),
          ),
          subtitle: Text(
            state.fileSize ?? '0B',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(state.fileSize == null ? 0.7 : 1.0),
            ),
          ),
        );
      },
    );
  }
}
