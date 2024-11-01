part of '../collection_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, CommonListState>(
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
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    final state = cubit.state;
    final appLocalizations = AppLocalizations.of(context)!;

    List<PopupMenuEntry> entries = [];

    if (state.code == LoadingStateCode.loaded && !state.isSelecting) {
      /// Edit mode button
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

    for (final entry in sortMap.entries) {
      final isSelected = state.sortOrder == entry.key;
      entries.add(
        PopupMenuItem(
          onTap: () {
            isSelected
                ? cubit.setListOrder(isAscending: !state.isAscending)
                : cubit.setListOrder(sortOrder: entry.key);
          },
          child: CommonPopupMenuSortListTile(
            isSelected: isSelected,
            isAscending: state.isAscending,
            title: entry.value,
          ),
        ),
      );
    }

    return entries;
  }
}
