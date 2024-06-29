import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../book_importer/book_importer_scaffold.dart';
import '../common_components/common_back_button.dart';
import '../edit_book/edit_book_scaffold.dart';
import 'bloc/toc_bloc.dart';

class TOCAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TOCAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (_, state) {
        final BookData bookData = BookData.fromName(state.bookName);
        return AppBar(
          leading: CommonBackButton(popValue: state.isDirty),
          title: Text(appLocalizations.titleTOC),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditBookScaffold(bookData: bookData)))
                    .then((newData) {
                  if (newData is BookData) {
                    cubit.setDirty();
                    cubit.refresh(newData: newData);
                    _showSnackBar(context, appLocalizations.editWhatSuccessfully(appLocalizations.book));
                  } else if (newData == false) {
                    _showSnackBar(context, appLocalizations.editWhatFailed(appLocalizations.book));
                  }
                });
              },
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BookImporterScaffold(bookData: bookData)))
                    .then((isSuccess) {
                  if (isSuccess == true) {
                    cubit.refresh();
                    _showSnackBar(context, appLocalizations.importWhatSuccessfully(appLocalizations.book));
                  } else if (isSuccess == false) {
                    _showSnackBar(context, appLocalizations.importWhatFailed(appLocalizations.book));
                  }
                });
              },
              icon: const Icon(Icons.save_alt_rounded),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String? message) {
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}

enum TOCAppBarActionType { edit, import }
