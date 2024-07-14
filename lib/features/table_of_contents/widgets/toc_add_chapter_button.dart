import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../add_chapter/add_chapter_scaffold.dart';
import '../bloc/toc_bloc.dart';

class TocAddChapterButton extends StatelessWidget {
  const TocAddChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (_) => AddChapterScaffold(bookName: BlocProvider.of<TocCubit>(context).state.bookName),
            ))
            .then((_) => BlocProvider.of<TocCubit>(context).refresh());
      },
      child: Icon(
        Icons.add,
        semanticLabel: AppLocalizations.of(context)!.accessibilityAddChapterButton,
      ),
    );
  }
}
