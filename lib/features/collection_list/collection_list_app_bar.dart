part of 'collection_list.dart';

class CollectionListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);
    final cubit = BlocProvider.of<CollectionListCubit>(context);

    return AppBar(
      leading: const Icon(Icons.collections_bookmark_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(AppLocalizations.of(context)!.collectionTitle),
      actions: [
        const _SelectButton(),
        BlocBuilder<CollectionListCubit, _State>(
          buildWhen: (previous, current) =>
              previous.isSelecting != current.isSelecting,
          builder: (context, state) {
            return CommonListDoneButton(
              isVisible: state.isSelecting,
              onPressed: () => cubit.setSelecting(false),
            );
          },
        ),
        const _PopupMenuButton(),
      ],
    );
  }
}
