import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/discover_browser_cubit.dart';
import '../cubits/discover_browser_state.dart';

class DiscoverBrowserTitle extends StatelessWidget {
  const DiscoverBrowserTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code ||
              previous.catalogFeed != current.catalogFeed,
      builder: (BuildContext context, DiscoverBrowserState state) {
        return Text(
            state.catalogFeed?.title ?? appLocalizations.generalDiscover);
      },
    );
  }
}
