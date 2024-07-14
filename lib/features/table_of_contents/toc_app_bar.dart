import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_edit_book_button.dart';
import 'widgets/toc_import_chapter_button.dart';

class TocAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TocAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.bookName != current.bookName,
      builder: (_, state) {
        return AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.titleTOC),
          actions: [
            TocEditBookButton(bookName: state.bookName),
            TocImportChapterButton(bookName: state.bookName),
          ],
        );
      },
    );
  }
}

enum TOCAppBarActionType { edit, import }
