import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../cubits/explore_browser_cubit.dart';
import '../../cubits/explore_browser_state.dart';

class ExploreBrowserFavoriteButton extends StatelessWidget {
  const ExploreBrowserFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreBrowserCubit cubit =
        BlocProvider.of<ExploreBrowserCubit>(context);
    return BlocBuilder<ExploreBrowserCubit, ExploreBrowserState>(
      buildWhen: (ExploreBrowserState previous, ExploreBrowserState current) =>
          previous.code != current.code ||
          previous.favoriteIdentifier != current.favoriteIdentifier,
      builder: (BuildContext context, ExploreBrowserState state) {
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
