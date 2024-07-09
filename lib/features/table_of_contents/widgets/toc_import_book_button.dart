import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../book_importer/book_importer_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocImportBookButton extends StatelessWidget {
  final String bookName;

  const TocImportBookButton({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final BookData bookData = BookData.fromName(bookName);
    return Semantics(
      label: appLocalizations.accessibilityImportBookButton,
      button: true,
      enabled: true,
      child: IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BookImporterScaffold(bookData: bookData)))
              .then((isSuccess) {
            if (isSuccess == true) {
              cubit.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.importBookSuccessfully),
              ));
            } else if (isSuccess == false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.importBookFailed),
              ));
            }
          });
        },
        icon: const Icon(Icons.save_alt_rounded),
      ),
    );
  }
}