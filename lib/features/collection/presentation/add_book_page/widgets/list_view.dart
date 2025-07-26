part of '../collection_add_book_scaffold.dart';

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final CollectionAddBookCubit cubit =
        BlocProvider.of<CollectionAddBookCubit>(context);

    return BlocBuilder<CollectionAddBookCubit, CollectionAddBookState>(
      buildWhen:
          (CollectionAddBookState previous, CollectionAddBookState current) =>
              previous.code != current.code ||
              previous.collectionList != current.collectionList ||
              previous.selectedCollections != current.selectedCollections,
      builder: (BuildContext context, CollectionAddBookState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonLoading();

          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return const SharedListEmpty();
            } else {
              return ListView.builder(
                itemCount: state.collectionList.length,
                itemBuilder: (BuildContext context, int index) {
                  final CollectionData data = state.collectionList[index];
                  final bool? isSelected =
                      state.selectedCollections.contains(data.id)
                          ? data.pathList.toSet().containsAll(state.bookPathSet)
                              ? true
                              : null
                          : false;

                  return CheckboxListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
                    title: Text(data.name),
                    secondary: const Icon(Icons.folder),
                    tristate: true,
                    value: isSelected,
                    onChanged: (bool? value) {
                      if (value == true) {
                        cubit.select(data.id);
                      } else {
                        cubit.deselect(data.id);
                      }
                    },
                  );
                },
              );
            }
        }
      },
    );
  }
}
