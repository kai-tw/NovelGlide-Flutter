part of '../../collection_service.dart';

class CollectionAddDialog extends StatelessWidget {
  const CollectionAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Try to get the cubit from the context.
    final CollectionListCubit? listCubit =
        context.select<CollectionListCubit?, CollectionListCubit?>(
            (CollectionListCubit? cubit) => cubit);
    final CollectionAddBookCubit? addBookCubit =
        context.select<CollectionAddBookCubit?, CollectionAddBookCubit?>(
            (CollectionAddBookCubit? cubit) => cubit);

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WindowSize.compact.maxWidth),
        child: BlocProvider<CollectionAddCubit>(
          create: (_) => CollectionAddCubit(
            listCubit: listCubit,
            addBookCubit: addBookCubit,
          ),
          child: const CollectionAddForm(),
        ),
      ),
    );
  }
}
