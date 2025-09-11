import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../cubits/explore_browser_cubit.dart';
import '../../cubits/explore_browser_state.dart';

class ExploreBrowserPreviousButton extends StatelessWidget {
  const ExploreBrowserPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);

    return BlocBuilder<ExploreBrowserCubit, ExploreBrowserState>(
      buildWhen: (ExploreBrowserState previous, ExploreBrowserState current) =>
          previous.code != current.code ||
          previous.historyStack != current.historyStack,
      builder: (BuildContext context, ExploreBrowserState state) {
        return IconButton(
          onPressed: state.code.isLoading || state.historyStack.isEmpty
              ? null
              : cubit.previousCatalog,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          tooltip: appLocalizations.generalPreviousPage,
        );
      },
    );
  }
}
