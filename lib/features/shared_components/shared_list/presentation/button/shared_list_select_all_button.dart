part of '../../shared_list.dart';

class SharedListSelectAllButton<T extends SharedListCubit<dynamic>>
    extends StatelessWidget {
  const SharedListSelectAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final T cubit = BlocProvider.of<T>(context);
    return BlocBuilder<T, SharedListState<dynamic>>(
      buildWhen: (SharedListState<dynamic> previous,
              SharedListState<dynamic> current) =>
          previous.isSelecting != current.isSelecting ||
          previous.dataList.isNotEmpty != current.dataList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (BuildContext context, SharedListState<dynamic> state) {
        Widget? child;

        if (state.isSelecting) {
          if (state.dataList.isNotEmpty) {
            child = TextButton(
              onPressed:
                  state.isSelectAll ? cubit.deselectAll : cubit.selectAll,
              child: Text(state.isSelectAll
                  ? appLocalizations.generalDeselectAll
                  : appLocalizations.generalSelectAll),
            );
          } else {
            child = TextButton(
              onPressed: null,
              child: Text(appLocalizations.generalSelectAll),
            );
          }
        }

        return SimpleFadeSwitcher(
          child: child,
        );
      },
    );
  }
}
