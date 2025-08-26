import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'cubits/discover_add_favorite_page_cubit.dart';
import 'discover_add_favorite_page_scaffold.dart';

class DiscoverAddFavoritePage extends StatelessWidget {
  const DiscoverAddFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscoverAddFavoritePageCubit>(
      create: (_) => sl<DiscoverAddFavoritePageCubit>(),
      child: const DiscoverAddFavoritePageScaffold(),
    );
  }
}
