import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/explore_browser_cubit.dart';

class ExploreBrowserUrlBar extends StatelessWidget {
  const ExploreBrowserUrlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);

    return TextField(
      controller: cubit.textEditingController,
      decoration: InputDecoration(
        labelText: appLocalizations.generalUrl,
        hintText: appLocalizations.exploreBrowserTypeUrl,
        suffixIcon: IconButton(
          onPressed: cubit.browseCatalog,
          icon: const Icon(Icons.search_rounded),
          tooltip: appLocalizations.exploreBrowserBrowse,
        ),
      ),
      onSubmitted: (_) => cubit.browseCatalog(),
    );
  }
}
