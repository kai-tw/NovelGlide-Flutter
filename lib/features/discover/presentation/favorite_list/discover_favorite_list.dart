import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../../shared_components/common_error_widgets/common_error_sliver_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_sliver_widget.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../add_favorite_page/discover_add_favorite_page.dart';
import 'cubit/discover_favorite_list_cubit.dart';
import 'cubit/discover_favorite_list_state.dart';
import 'discover_favorite_list_item.dart';

class DiscoverFavoriteList extends StatelessWidget {
  const DiscoverFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscoverFavoriteListCubit>(
      create: (_) => sl<DiscoverFavoriteListCubit>()..getFavoriteList(),
      child: BlocBuilder<DiscoverFavoriteListCubit, DiscoverFavoriteListState>(
        buildWhen: (DiscoverFavoriteListState previous,
                DiscoverFavoriteListState current) =>
            previous.code != current.code,
        builder: _buildScrollView,
      ),
    );
  }

  Widget _buildScrollView(
    BuildContext context,
    DiscoverFavoriteListState state,
  ) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DiscoverFavoriteListCubit cubit =
        BlocProvider.of<DiscoverFavoriteListCubit>(context);
    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: cubit.getFavoriteList,
        child: CustomScrollView(
          slivers: <Widget>[
            // Title
            SliverToBoxAdapter(
              child: ListTile(
                leading: const Icon(Icons.favorite_rounded),
                title: Text(
                  appLocalizations.discoverFavorites,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            // SliverList
            switch (state.code) {
              LoadingStateCode.initial ||
              LoadingStateCode.loading ||
              LoadingStateCode.backgroundLoading =>
                const CommonLoadingSliverWidget(),
              LoadingStateCode.error => const CommonErrorSliverWidget(),
              LoadingStateCode.loaded => state.catalogList.isEmpty
                  ? const SharedListSliverEmpty()
                  : _buildList(context, state),
            },

            // Add Favorite button
            SliverToBoxAdapter(
              child: ListTile(
                leading: const Icon(Icons.add_rounded),
                title: Text(appLocalizations.discoverAddFavorite),
                onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const DiscoverAddFavoritePage(),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    DiscoverFavoriteListState state,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return DiscoverFavoriteListItem(
            catalog: state.catalogList[index],
          );
        },
        childCount: state.catalogList.length,
      ),
    );
  }
}
