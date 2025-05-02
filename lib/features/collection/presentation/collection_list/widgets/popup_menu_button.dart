part of '../collection_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, CommonListState<CollectionData>>(
      buildWhen: (CommonListState<CollectionData> previous,
              CommonListState<CollectionData> current) =>
          previous.code != current.code,
      builder: (BuildContext context, CommonListState<CollectionData> state) {
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
    final CommonListState<CollectionData> state = cubit.state;

    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    /// Selecting mode
    if (state.code.isLoaded && !state.isSelecting) {
      entries.addAll(<PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          onTap: () => cubit.isSelecting = true,
          child: const CommonListSelectModeButton(),
        ),
        const PopupMenuDivider(),
      ]);
    }

    /// Sorting Section
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
          child: const CommonListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
