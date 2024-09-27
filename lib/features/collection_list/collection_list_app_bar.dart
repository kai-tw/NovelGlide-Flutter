import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_class.dart';
import 'bloc/collection_list_bloc.dart';

class CollectionListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit = BlocProvider.of<CollectionListCubit>(context);
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    return AppBar(
      leading: const Icon(Icons.collections_bookmark_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(AppLocalizations.of(context)!.collectionTitle),
      actions: [
        /// Select all button
        BlocBuilder<CollectionListCubit, CollectionListState>(
          buildWhen: (previous, current) =>
              previous.isSelecting != current.isSelecting ||
              previous.selectedCollections != current.selectedCollections,
          builder: (context, state) {
            final bool isSelectAll = state.selectedCollections.length == state.collectionList.length;
            Widget? child;

            if (state.isSelecting) {
              child = TextButton(
                onPressed: () {
                  if (isSelectAll) {
                    cubit.deselectAll();
                  } else {
                    cubit.selectAll();
                  }
                },
                child: Text(isSelectAll ? appLocalizations.generalDeselectAll : appLocalizations.generalSelectAll),
              );
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: child,
            );
          },
        ),

        /// Select done button
        BlocBuilder<CollectionListCubit, CollectionListState>(
          buildWhen: (previous, current) => previous.isSelecting != current.isSelecting,
          builder: (context, state) {
            Widget? child;

            if (state.isSelecting) {
              child = TextButton(
                onPressed: () => cubit.setSelecting(false),
                child: Text(appLocalizations.generalDone),
              );
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: child,
            );
          },
        ),

        /// More button.
        BlocBuilder<CollectionListCubit, CollectionListState>(
          buildWhen: (previous, current) => previous.code != current.code,
          builder: (context, state) {
            return PopupMenuButton(
              enabled: state.code == LoadingStateCode.loaded,
              icon: const Icon(Icons.more_vert_rounded),
              clipBehavior: Clip.hardEdge,
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry> entries = [];

                if (!cubit.state.isSelecting) {
                  /// Active selection
                  entries.add(PopupMenuItem(
                    onTap: () => cubit.setSelecting(true),
                    child: ListTile(
                      leading: const SizedBox(width: 24.0),
                      title: Text(appLocalizations.generalSelect),
                      trailing: const Icon(Icons.check_circle_outline_rounded),
                    ),
                  ));

                  /// Divider
                  entries.add(const PopupMenuDivider());
                }

                Map<SortOrderCode, String> sortMap = {
                  SortOrderCode.name: appLocalizations.generalName,
                };

                for (MapEntry<SortOrderCode, String> entry in sortMap.entries) {
                  bool isSelected = cubit.state.sortOrder == entry.key;
                  entries.add(
                    PopupMenuItem(
                      onTap: () {
                        if (isSelected) {
                          cubit.setListOrder(isAscending: !cubit.state.isAscending);
                        } else {
                          cubit.setListOrder(sortOrder: entry.key);
                        }
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: isSelected ? const Icon(Icons.check_rounded) : const SizedBox(width: 24.0),
                        title: Text(entry.value),
                        trailing: isSelected
                            ? Icon(cubit.state.isAscending ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down)
                            : const SizedBox(width: 24.0),
                      ),
                    ),
                  );
                }

                return entries;
              },
            );
          },
        ),
      ],
    );
  }
}
