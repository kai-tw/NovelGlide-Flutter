import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../../data/window_class.dart';
import '../../edit_book/edit_book_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocEditBookButton extends StatelessWidget {
  final String bookName;

  const TocEditBookButton({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final BookData bookData = BookData.fromName(bookName);
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => EditBookScaffold(bookData: bookData)))
            .then((_) => BlocProvider.of<TocCubit>(context).refresh());
      },
      icon: Icon(
        Icons.edit_rounded,
        semanticLabel: AppLocalizations.of(context)!.accessibilityEditBookButton,
      ),
    );
  }
}
