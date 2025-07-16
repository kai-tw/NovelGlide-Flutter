part of '../collection_viewer.dart';

class CollectionViewerMenuButton extends StatelessWidget {
  const CollectionViewerMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionViewerCubit, CollectionViewerState>(
      buildWhen:
          (CollectionViewerState previous, CollectionViewerState current) =>
              previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, CollectionViewerState state) {
        if (state.isSelecting) {
          return PopupMenuButton<void>(
            clipBehavior: Clip.hardEdge,
            itemBuilder: _itemBuilder,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (cubit.state.code.isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      PopupMenuUtils.addSection(entries, <PopupMenuItem<void>>[
        SharedList.buildSelectionModeButton(context: context, cubit: cubit),
      ]);
    }

    // Operation Section
    if (cubit.state.code.isLoaded &&
        cubit.state.isSelecting &&
        cubit.state.selectedSet.isNotEmpty) {
      PopupMenuUtils.addSection(entries, <PopupMenuItem<void>>[
        PopupMenuItem<void>(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return CommonDeleteDialog(
                  onDelete: cubit.remove,
                );
              },
            );
          },
          child: const SharedListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
