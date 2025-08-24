import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/discover_browser_cubit.dart';

class DiscoverBrowserUrlBar extends StatelessWidget {
  const DiscoverBrowserUrlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return TextField(
      controller: cubit.textEditingController,
      decoration: InputDecoration(
        hintText: appLocalizations.discoverBrowserTypeUrl,
        suffixIcon: IconButton(
          onPressed: cubit.browseCatalog,
          icon: const Icon(Icons.search_rounded),
          tooltip: appLocalizations.discoverBrowserBrowse,
        ),
      ),
      onSubmitted: (_) => cubit.browseCatalog(),
    );
  }
}
