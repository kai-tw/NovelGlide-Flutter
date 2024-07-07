import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../edit_book/edit_book_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocEditBookButton extends StatelessWidget {
  final String bookName;

  const TocEditBookButton({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final BookData bookData = BookData.fromName(bookName);
    return Semantics(
      label: appLocalizations.accessibilityEditBookButton,
      child: IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => EditBookScaffold(bookData: bookData)))
              .then((newData) {
            if (newData is BookData) {
              cubit.setDirty();
              cubit.refresh(newData: newData);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.editWhatSuccessfully(appLocalizations.book)),
              ));
            } else if (newData == false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.editWhatFailed(appLocalizations.book)),
              ));
            }
          });
        },
        icon: const Icon(Icons.edit_rounded),
      ),
    );
  }
}