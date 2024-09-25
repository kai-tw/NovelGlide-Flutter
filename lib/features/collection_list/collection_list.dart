import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/collection_data.dart';
import '../../data/loading_state_code.dart';
import '../../toolbox/route_helper.dart';
import '../collection_viewer/collection_viewer.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/collection_list_bloc.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit = BlocProvider.of<CollectionListCubit>(context)..refresh();

    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.collectionList != current.collectionList ||
          previous.isSelecting != current.isSelecting ||
          previous.selectedCollections != current.selectedCollections,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 72.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final CollectionData data = state.collectionList[index];
                      final Set<CollectionData> selectedSet = state.selectedCollections;
                      void Function() onTap;
                      Widget? trailing;

                      if (state.isSelecting) {
                        onTap = () {
                          if (selectedSet.contains(data)) {
                            cubit.deselectCollection(data);
                          } else {
                            cubit.selectCollection(data);
                          }
                        };
                        trailing = Semantics(
                          label: selectedSet.contains(data)
                              ? appLocalizations.collectionDeselect
                              : appLocalizations.collectionSelect,
                          child: Checkbox(
                            value: selectedSet.contains(data),
                            onChanged: (_) => onTap(),
                          ),
                        );
                      } else {
                        onTap = () =>
                            Navigator.of(context).push(RouteHelper.pushRoute(CollectionViewer(collectionData: data)));
                      }

                      return ListTile(
                        onTap: onTap,
                        leading: const Icon(Icons.folder_rounded),
                        title: Text(data.name),
                        trailing: trailing,
                        minLeadingWidth: 40.0,
                      );
                    },
                    childCount: state.collectionList.length,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
