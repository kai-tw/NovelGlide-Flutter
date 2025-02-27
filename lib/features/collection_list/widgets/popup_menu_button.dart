part of '../collection_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, CommonListState<CollectionData>>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return PopupMenuButton(
          enabled: state.code == LoadingStateCode.loaded,
          icon: const Icon(Icons.more_vert_rounded),
          clipBehavior: Clip.hardEdge,
          itemBuilder: _itemBuilder,
        );
      },
    );
  }

  List<PopupMenuEntry> _itemBuilder(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    final state = cubit.state;

    List<PopupMenuEntry> entries = [];

    /// Selecting mode
    if (state.code.isLoaded && !state.isSelecting) {
      entries.addAll([
        PopupMenuItem(
          onTap: () => cubit.setSelecting(true),
          child: const CommonListSelectModeButton(),
        ),
        const PopupMenuDivider(),
      ]);
    }

    /// Sorting Section
    final sortMap = {
      SortOrderCode.name: appLocalizations.generalName,
    };

    for (final entry in sortMap.entries) {
      final isSelected = state.sortOrder == entry.key;
      entries.add(
        PopupMenuItem(
          onTap: () {
            isSelected
                ? cubit.setListOrder(isAscending: !state.isAscending)
                : cubit.setListOrder(sortOrder: entry.key);
          },
          child: CommonListSortButton(
            isSelected: isSelected,
            isAscending: state.isAscending,
            title: entry.value,
          ),
        ),
      );
    }

    /// Operation Section
    if (state.code.isLoaded && state.isSelecting) {
      entries.addAll([
        const PopupMenuDivider(),
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CommonDeleteDialog(
                  onDelete: () => cubit.deleteSelectedCollections(),
                );
              },
            );
          },
          enabled: cubit.state.selectedSet.isNotEmpty,
          child: const CommonListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
