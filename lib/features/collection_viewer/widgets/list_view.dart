part of '../collection_viewer.dart';

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.bookList != current.bookList,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.loaded:
            if (state.bookList.isEmpty) {
              return const CommonListEmpty();
            } else {
              return ReorderableListView.builder(
                onReorder: cubit.reorder,
                itemCount: state.bookList.length,
                itemBuilder: (context, index) {
                  final data = state.bookList[index];
                  return ListTile(
                    key: ValueKey(data.filePath),
                    onTap: () {
                      Navigator.of(context)
                          .push(RouteUtils.pushRoute(TableOfContents(data)))
                          .then((_) => cubit.refresh());
                    },
                    leading: const Icon(Icons.book_outlined),
                    title: Text(data.name),
                    trailing: const Icon(Icons.drag_handle_rounded),
                  );
                },
              );
            }
        }
      },
    );
  }
}
