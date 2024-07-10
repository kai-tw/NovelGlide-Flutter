import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../../data/window_class.dart';
import '../../book_importer/book_importer_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocImportBookButton extends StatelessWidget {
  final String bookName;

  const TocImportBookButton({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final BookData bookData = BookData.fromName(bookName);
    return IconButton(
      onPressed: () {
        _navigateToImportBook(context, bookData).then((isSuccess) => _onPopBack(context, isSuccess));
      },
      icon: Icon(
        Icons.save_alt_rounded,
        semanticLabel: AppLocalizations.of(context)!.accessibilityImportBookButton,
      ),
    );
  }

  /// Based on the window size, navigate to the import book page
  Future<dynamic> _navigateToImportBook(BuildContext context, BookData bookData) async {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    switch (windowClass) {
      /// Push to the import book page
      case WindowClass.compact:
        return Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookImporterScaffold(bookData: bookData)));

      /// Show in a dialog
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 360.0,
                child: BookImporterScaffold(bookData: bookData),
              ),
            );
          },
        );
    }
  }

  /// Handle the result of importing a book
  void _onPopBack(BuildContext context, dynamic isSuccess) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
  }
}
