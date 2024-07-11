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
        _navigateToEditBook(context, bookData).then((newData) => _onPopBack(context, newData));
      },
      icon: Icon(
        Icons.edit_rounded,
        semanticLabel: AppLocalizations.of(context)!.accessibilityEditBookButton,
      ),
    );
  }

  /// Based on the window size, navigate to the edit book page
  Future<dynamic> _navigateToEditBook(BuildContext context, BookData bookData) async {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    switch (windowClass) {
      /// Push to the edit book page
      case WindowClass.compact:
        return Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditBookScaffold(bookData: bookData)));

      /// Show in a dialog
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 360.0,
                child: EditBookScaffold(
                  bookData: bookData,
                ),
              ),
            );
          },
        );
    }
  }

  /// Handle the result of editing the book
  void _onPopBack(BuildContext context, dynamic newData) {
    if (newData is BookData) {
      /// Refresh the table of contents
      BlocProvider.of<TocCubit>(context).setDirty();
      BlocProvider.of<TocCubit>(context).refresh(newData: newData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.editBookSuccessfully),
      ));
    } else if (newData == false) {
      /// Failed to edit the book
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.editBookFailed),
      ));
    }
  }
}
