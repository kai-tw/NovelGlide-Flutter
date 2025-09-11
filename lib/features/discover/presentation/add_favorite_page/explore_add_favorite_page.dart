import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'cubits/explore_add_favorite_page_cubit.dart';
import 'explore_add_favorite_page_scaffold.dart';

class ExploreAddFavoritePage extends StatelessWidget {
  const ExploreAddFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExploreAddFavoritePageCubit>(
      create: (_) => sl<ExploreAddFavoritePageCubit>(),
      child: const ExploreAddFavoritePageScaffold(),
    );
  }
}
