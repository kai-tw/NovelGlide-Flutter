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
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Semantics(
      label: appLocalizations.accessibilityAddBookButton,
      button: true,
      enabled: true,
      child: FloatingActionButton(
        onPressed: () {
          final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
          switch (windowClass) {
            case WindowClass.compact:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) => const AddBookScaffold()))
                  .then((isSuccess) => _onBack(context, isSuccess));
              break;
            default:
              showDialog(
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
              ).then((isSuccess) => _onBack(context, isSuccess));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onBack(BuildContext context, dynamic isSuccess) {
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
