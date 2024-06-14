import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return AppBar(
      leading: BlocBuilder<TOCCubit, TOCState>(builder: (_, state) => CommonBackButton(popValue: state.isDirty)),
      title: Text(appLocalizations.titleTOC),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => EditBookScaffold(bookData: cubit.bookData)))
                .then((isSuccess) => _onPopBack(context, TOCAppBarActionType.edit, isSuccess));
          },
          icon: const Icon(Icons.edit_rounded),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => BookImporterScaffold(bookData: cubit.bookData)))
                .then((isSuccess) => _onPopBack(context, TOCAppBarActionType.import, isSuccess));
          },
          icon: const Icon(Icons.save_alt_rounded),
        ),
      ],
    );
  }

  void _onPopBack(BuildContext context, TOCAppBarActionType actionType, bool? isSuccess) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    String? messageOnSuccess, messageOnFailure;

    switch (actionType) {
      case TOCAppBarActionType.edit:
        messageOnSuccess = appLocalizations.editWhatSuccessfully(appLocalizations.book);
        messageOnFailure = appLocalizations.editWhatFailed(appLocalizations.book);
        break;
      case TOCAppBarActionType.import:
        messageOnSuccess = appLocalizations.importWhatSuccessfully(appLocalizations.book);
        messageOnFailure = appLocalizations.importWhatFailed(appLocalizations.book);
        break;
    }

    if (isSuccess == true) {
      cubit.setDirty();
      cubit.refresh(isForce: true);
      _showSnackBar(context, messageOnSuccess);
    } else if (isSuccess == false) {
      _showSnackBar(context, messageOnFailure);
    }
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
