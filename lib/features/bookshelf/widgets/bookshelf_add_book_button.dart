import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/window_class.dart';
import '../../add_book/add_book_scaffold.dart';
import '../bloc/bookshelf_bloc.dart';

class BookshelfAddBookButton extends StatelessWidget {
  const BookshelfAddBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _navigateToAddBook(context).then((isSuccess) => _onPopBack(context, isSuccess));
      },
      child: Icon(
        Icons.add,
        semanticLabel: AppLocalizations.of(context)!.accessibilityAddBookButton,
      ),
    );
  }

  /// Based on the window size, navigate to the add book page
  Future<dynamic> _navigateToAddBook(BuildContext context) async {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    switch (windowClass) {
      /// Push to the add book page
      case WindowClass.compact:
        return Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBookScaffold()));

      /// Show in a dialog
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Dialog(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 360.0,
                child: AddBookScaffold(),
              ),
            );
          },
        );
    }
  }

  /// Handle the result of adding a book
  void _onPopBack(BuildContext context, dynamic isSuccess) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (isSuccess == true) {
      cubit.refresh();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addBookSuccessfully),
      ));
    } else if (isSuccess == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addBookFailed),
      ));
    }
  }
}
