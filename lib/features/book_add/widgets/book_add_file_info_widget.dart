import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart';

import '../../../toolbox/file_helper.dart';
import '../bloc/book_add_bloc.dart';

class BookAddFileInfoWidget extends StatelessWidget {
  const BookAddFileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        final fileName = state.file != null
            ? basename(state.file!.path)
            : appLocalizations.fileEmpty;
        final fileSize = state.file?.lengthSync() ?? 0;
        final textStyle = TextStyle(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(state.file == null ? 0.7 : 1.0),
        );

        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            fileName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          subtitle: Text(
            FileHelper.getFileSizeString(fileSize),
            style: textStyle,
          ),
        );
      },
    );
  }
}
