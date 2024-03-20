import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_chapter/add_chapter_callee_add_button.dart';
import '../common_components/common_back_button.dart';
import '../edit_book/edit_book_callee_edit_button.dart';
import 'bloc/toc_bloc.dart';

class TOCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TOCAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      leading: const CommonBackButton(),
      actions: [
        const AddChapterCalleeAddButton(),
        EditBookCalleeEditButton(
          bookObject: cubit.bookObject,
          onSuccess: () => cubit.refresh(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
