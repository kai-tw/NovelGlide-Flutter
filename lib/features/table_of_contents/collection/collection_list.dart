part of '../table_of_contents.dart';

class _CollectionList extends StatelessWidget {
  const _CollectionList();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_CollectionCubit>(context);

    return BlocBuilder<_CollectionCubit, _CollectionState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.selectedCollections != current.selectedCollections,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return const CommonListEmpty();
            } else {
              return ListView.builder(
                itemCount: state.collectionList.length,
                itemBuilder: (context, index) {
                  final data = state.collectionList[index];
                  final isSelected =
                      state.selectedCollections.contains(data.id);

                  return CheckboxListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
                    title: Text(data.name),
                    secondary: const Icon(Icons.folder),
                    value: isSelected,
                    onChanged: (_) {
                      if (isSelected) {
                        cubit.deselect(data.id);
                      } else {
                        cubit.select(data.id);
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
