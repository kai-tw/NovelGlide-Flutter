import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../cubits/explore_browser_cubit.dart';
import '../../cubits/explore_browser_state.dart';

class ExploreBrowserNextButton extends StatelessWidget {
  const ExploreBrowserNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);

    return BlocBuilder<ExploreBrowserCubit, ExploreBrowserState>(
      buildWhen: (ExploreBrowserState previous, ExploreBrowserState current) =>
          previous.code != current.code ||
          previous.restoreStack != current.restoreStack,
      builder: (BuildContext context, ExploreBrowserState state) {
        return IconButton(
          onPressed: state.code.isLoading || state.restoreStack.isEmpty
              ? null
              : cubit.nextCatalog,
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          tooltip: appLocalizations.generalNextPage,
        );
      },
    );
  }
}
