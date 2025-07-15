part of '../collection_list.dart';

class CollectionListAppBarMoreButton extends StatelessWidget {
  const CollectionListAppBarMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      clipBehavior: Clip.hardEdge,
      itemBuilder: _itemBuilder,
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);

    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (cubit.state.code.isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      PopupMenuUtils.addSection(entries,
          SharedListSelectModeTile.itemBuilder<CollectionListCubit>(context));
    }

    // Sorting Section
    PopupMenuUtils.addSection(
      entries,
      SharedList.buildSortMenu(
        titleList: <String>[
          appLocalizations.generalName,
        ],
        sortOrderList: <SortOrderCode>[
          SortOrderCode.name,
        ],
        cubit: cubit,
      ),
    );

    // Operation Section
    if (cubit.state.code.isLoaded &&
        cubit.state.isSelecting &&
        cubit.state.selectedSet.isNotEmpty) {
      entries.addAll(<PopupMenuEntry<void>>[
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

  /// ==========================================================
  /// Click Handler

  /// Tap on sorting button
  void _onTapSorting(BuildContext context, SortOrderCode sortOrder) {
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    if (cubit.state.sortOrder == sortOrder) {
      cubit.setListOrder(isAscending: !cubit.state.isAscending);
    } else {
      cubit.setListOrder(sortOrder: sortOrder);
    }
  }
}
