import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../add_favorite_page/explore_add_favorite_page.dart';
import 'cubit/explore_favorite_list_cubit.dart';
import 'cubit/explore_favorite_list_state.dart';
import 'explore_favorite_list_item.dart';

class ExploreFavoriteList extends StatelessWidget {
  const ExploreFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExploreFavoriteListCubit>(
      create: (_) => sl<ExploreFavoriteListCubit>()..getFavoriteList(),
      child: BlocBuilder<ExploreFavoriteListCubit, ExploreFavoriteListState>(
        buildWhen: (ExploreFavoriteListState previous,
                ExploreFavoriteListState current) =>
            previous.code != current.code,
        builder: _buildScrollView,
      ),
    );
  }

  Widget _buildScrollView(
    BuildContext context,
    ExploreFavoriteListState state,
  ) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      child: Column(
        children: <Widget>[
          // Title
          ListTile(
            title: Text(
              appLocalizations.discoverFavorites,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),

          // SliverList
          Expanded(
            child: switch (state.code) {
              LoadingStateCode.initial ||
              LoadingStateCode.loading ||
              LoadingStateCode.backgroundLoading =>
                const CommonLoadingWidget(),
              LoadingStateCode.error => const CommonErrorWidget(),
              LoadingStateCode.loaded => _buildList(context, state),
            },
          ),

          // Add Favorite button
          ListTile(
            leading: const Icon(Icons.add_rounded),
            title: Text(appLocalizations.discoverAddToFavorites),
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => const ExploreAddFavoritePage(),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    ExploreFavoriteListState state,
  ) {
    final ExploreFavoriteListCubit cubit =
        BlocProvider.of<ExploreFavoriteListCubit>(context);

    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: cubit.getFavoriteList,
        child: CustomScrollView(
          slivers: <Widget>[
            state.catalogList.isEmpty
                ? const SharedListSliverEmpty()
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ExploreFavoriteListItem(
                          catalog: state.catalogList[index],
                        );
                      },
                      childCount: state.catalogList.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
