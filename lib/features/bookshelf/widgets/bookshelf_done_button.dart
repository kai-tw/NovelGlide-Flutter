import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookshelf_bloc.dart';

class BookshelfDoneButton extends StatelessWidget {
  const BookshelfDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = TextButton(
            onPressed: () => cubit.setSelecting(false),
            child: Text(appLocalizations.generalDone),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
      },
    );
  }
}
