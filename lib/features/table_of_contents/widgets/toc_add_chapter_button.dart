import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../add_chapter/add_chapter_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocAddChapterButton extends StatelessWidget {
  const TocAddChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.accessibilityAddChapterButton,
      button: true,
      enabled: true,
      child: BlocBuilder<TocCubit, TocState>(
        buildWhen: (previous, current) => previous.bookName != current.bookName,
        builder: (_, state) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddChapterScaffold(bookName: state.bookName)))
                  .then((isSuccess) => _onPopBack(context, isSuccess));
            },
          );
        },
      ),
    );
  }

  void _onPopBack(BuildContext context, bool? isSuccess) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (isSuccess == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addChapterSuccessfully),
      ));
    } else if (isSuccess == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addChapterFailed),
      ));
    }
  }
}