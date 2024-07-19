import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../chapter_importer/chapter_importer_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocImportChapterButton extends StatelessWidget {
  final String bookName;

  const TocImportChapterButton({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final BookData bookData = BookData.fromName(bookName);
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ChapterImporterScaffold(bookData: bookData)))
            .then((_) => BlocProvider.of<TocCubit>(context).refresh());
      },
      icon: Icon(
        Icons.save_alt_rounded,
        semanticLabel: AppLocalizations.of(context)!.accessibilityImportBookButton,
      ),
    );
  }
}
