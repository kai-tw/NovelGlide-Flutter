import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/collection_list_bloc.dart';

class CollectionListDoneButton extends StatelessWidget {
  const CollectionListDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, CollectionListState>(
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
