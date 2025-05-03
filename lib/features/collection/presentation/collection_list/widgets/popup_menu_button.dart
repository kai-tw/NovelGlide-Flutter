part of '../collection_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, SharedListState<CollectionData>>(
      buildWhen: (SharedListState<CollectionData> previous,
              SharedListState<CollectionData> current) =>
          previous.code != current.code,
      builder: (BuildContext context, SharedListState<CollectionData> state) {
        return PopupMenuButton<void>(
          enabled: state.code == LoadingStateCode.loaded,
          icon: const Icon(Icons.more_vert_rounded),
          clipBehavior: Clip.hardEdge,
          itemBuilder: _itemBuilder,
        );
      },
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    final SharedListState<CollectionData> state = cubit.state;

    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (cubit.state.code.isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      entries.addAll(<PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          onTap: () => cubit.isSelecting = true,
          child: const SharedListSelectModeTile(),
        ),
        const PopupMenuDivider(),
      ]);
    }

    // Sorting Section
    final Map<SortOrderCode, String> sortMap = <SortOrderCode, String>{
      SortOrderCode.name: appLocalizations.generalName,
    };

    for (final MapEntry<SortOrderCode, String> entry in sortMap.entries) {
      final bool isSelected = state.sortOrder == entry.key;
      entries.add(
        PopupMenuItem<void>(
          onTap: () {
            isSelected
                ? cubit.setListOrder(isAscending: !state.isAscending)
                : cubit.setListOrder(sortOrder: entry.key);
          },
          child: SharedListSortButton(
            isSelected: isSelected,
            isAscending: state.isAscending,
            title: entry.value,
          ),
        ),
      );
    }

    // Operation Section
    if (state.code.isLoaded && state.isSelecting) {
      entries.addAll(<PopupMenuEntry<void>>[
        const PopupMenuDivider(),
        PopupMenuItem<void>(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return CommonDeleteDialog(
                  onDelete: () => cubit.deleteSelectedCollections(),
                );
              },
            );
          },
          enabled: cubit.state.selectedSet.isNotEmpty,
          child: const SharedListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
