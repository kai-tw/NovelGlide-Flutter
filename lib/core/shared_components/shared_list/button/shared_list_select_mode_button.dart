part of '../shared_list.dart';

class SharedListSelectModeButton<T extends SharedListCubit<dynamic>>
    extends StatelessWidget {
  const SharedListSelectModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final T cubit = BlocProvider.of<T>(context);
    return BlocBuilder<T, SharedListState<dynamic>>(
      buildWhen: (SharedListState<dynamic> previous,
          SharedListState<dynamic> current) {
        return previous.code != current.code ||
            previous.isSelecting != current.isSelecting ||
            previous.dataList != current.dataList;
      },
      builder: (BuildContext context, SharedListState<dynamic> state) {
        if (state.code.isLoaded &&
            !state.isSelecting &&
            state.dataList.isNotEmpty) {
          return IconButton(
            onPressed: () => cubit.isSelecting = true,
            icon: const Icon(Icons.check_circle_outline_rounded),
            tooltip: appLocalizations.generalSelect,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
