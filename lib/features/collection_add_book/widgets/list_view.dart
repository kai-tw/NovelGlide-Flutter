part of '../collection_add_book_scaffold.dart';

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.collectionList != current.collectionList ||
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
                  final isSelected = state.selectedCollections.contains(data.id)
                      ? data.pathList.toSet().containsAll(cubit.pathSet)
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
                    onChanged: (value) {
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
