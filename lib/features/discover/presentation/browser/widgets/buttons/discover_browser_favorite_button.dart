import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../cubits/discover_browser_cubit.dart';
import '../../cubits/discover_browser_state.dart';

class DiscoverBrowserFavoriteButton extends StatelessWidget {
  const DiscoverBrowserFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);
    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code ||
              previous.favoriteIdentifier != current.favoriteIdentifier,
      builder: (BuildContext context, DiscoverBrowserState state) {
        final bool isFavorite = state.favoriteIdentifier != null;
        return IconButton(
          icon: const Icon(Icons.favorite_rounded),
          color: isFavorite ? Theme.of(context).colorScheme.error : null,
          tooltip: isFavorite
              ? appLocalizations.discoverRemoveFromFavorites
              : appLocalizations.discoverAddToFavorites,
          onPressed: state.code.isLoaded
              ? () {
                  if (isFavorite) {
                    // Remove from favorite list
                    cubit.removeFromFavoriteList();
                  } else {
                    // Add to favorite list
                    cubit.addToFavoriteList();
                  }
                }
              : null,
        );
      },
    );
  }
}
