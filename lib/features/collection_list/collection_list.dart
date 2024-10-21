import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/loading_state_code.dart';
import '../../enum/window_class.dart';
import '../../toolbox/route_helper.dart';
import '../collection_viewer/collection_viewer.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/collection_list_bloc.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<CollectionListCubit>(context)..refresh();
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.getClassByWidth(windowWidth);

    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.collectionList != current.collectionList ||
          previous.isSelecting != current.isSelecting ||
          previous.selectedCollections != current.selectedCollections,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return CommonSliverListEmpty(
                title: appLocalizations.collectionNoCollection,
              );
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(
                  top: windowClass == WindowClass.compact ? 0.0 : 16.0,
                  bottom: MediaQuery.of(context).padding.bottom + 72.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final data = state.collectionList[index];
                      const icon = Icon(Icons.folder_rounded);
                      final title = Text(data.name);

                      if (state.isSelecting) {
                        final isSelected =
                            state.selectedCollections.contains(data);
                        return CheckboxListTile(
                          title: title,
                          secondary: icon,
                          value: isSelected,
                          onChanged: (_) {
                            if (isSelected) {
                              cubit.deselectCollection(data);
                            } else {
                              cubit.selectCollection(data);
                            }
                          },
                        );
                      } else {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              RouteHelper.pushRoute(
                                CollectionViewer(collectionData: data),
                              ),
                            );
                          },
                          leading: icon,
                          title: title,
                        );
                      }
                    },
                    childCount: state.collectionList.length,
                  ),
                ),
              );
            }

          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();
        }
      },
    );
  }
}
