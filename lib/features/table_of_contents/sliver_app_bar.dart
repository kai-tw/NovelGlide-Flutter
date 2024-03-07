import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_back_button.dart';
import '../edit_book/edit_book_callee_edit_button.dart';
import '../edit_book/edit_book_scaffold.dart';
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
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
        EditBookCalleeEditButton(
          bookObject: tocCubit.state.bookObject,
          onSuccess: () => tocCubit.refresh(),
        ),
      ],
    );
  }
}
