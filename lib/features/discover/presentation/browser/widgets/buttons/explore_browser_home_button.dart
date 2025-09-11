import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../cubits/explore_browser_cubit.dart';
import '../../cubits/explore_browser_state.dart';

class ExploreBrowserHomeButton extends StatelessWidget {
  const ExploreBrowserHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);

    return BlocBuilder<ExploreBrowserCubit, ExploreBrowserState>(
      buildWhen: (ExploreBrowserState previous, ExploreBrowserState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ExploreBrowserState state) {
        return IconButton(
          onPressed: state.code.isInitial || state.code.isLoading
              ? null
              : cubit.goHome,
          icon: const Icon(Icons.home_rounded),
          tooltip: appLocalizations.generalHomepage,
        );
      },
    );
  }
}
