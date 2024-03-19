import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_chapter/add_chapter_callee_add_button.dart';
import '../common_components/common_back_button.dart';
import '../edit_book/edit_book_callee_edit_button.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverAppBar extends StatelessWidget {
  const TOCSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    TOCCubit tocCubit = BlocProvider.of<TOCCubit>(context);
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      leading: const CommonBackButton(),
      actions: [
        const AddChapterCalleeAddButton(),
        EditBookCalleeEditButton(
          bookObject: tocCubit.state.bookObject,
          onSuccess: () => tocCubit.refresh(),
        ),
      ],
    );
  }
}
