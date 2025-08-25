import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/discover_browser_cubit.dart';
import '../../cubits/discover_browser_state.dart';

class DiscoverBrowserFavoriteButton extends StatelessWidget {
  const DiscoverBrowserFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);
    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code ||
              previous.favoriteIdentifier != current.favoriteIdentifier,
      builder: (BuildContext context, DiscoverBrowserState state) {
        return IconButton(
          icon: const Icon(Icons.favorite_rounded),
          color: state.favoriteIdentifier == null
              ? null
              : Theme.of(context).colorScheme.error,
          tooltip: 'Favorite',
          onPressed: state.code.isLoaded
              ? () {
                  if (state.favoriteIdentifier == null) {
                    // Add to favorite list
                    cubit.addToFavoriteList();
                  } else {
                    // Remove from favorite list
                    cubit.removeFromFavoriteList();
                  }
                }
              : null,
        );
      },
    );
  }
}
