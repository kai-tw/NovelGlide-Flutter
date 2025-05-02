part of '../shared_list.dart';

class SharedListSelectAllButton<M extends SharedListCubit<T>, T>
    extends StatelessWidget {
  const SharedListSelectAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final M cubit = BlocProvider.of<M>(context);
    return BlocBuilder<M, SharedListState<T>>(
      buildWhen: (SharedListState<T> previous, SharedListState<T> current) =>
          previous.isSelecting != current.isSelecting ||
          previous.dataList.isNotEmpty != current.dataList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (BuildContext context, SharedListState<T> state) {
        Widget? child;

        if (state.isSelecting) {
          final AppLocalizations appLocalizations =
              AppLocalizations.of(context)!;
          if (state.dataList.isNotEmpty) {
            return TextButton(
              onPressed:
                  state.isSelectAll ? cubit.deselectAll : cubit.selectAll,
              child: Text(state.isSelectAll
                  ? appLocalizations.generalDeselectAll
                  : appLocalizations.generalSelectAll),
            );
          } else {
            return TextButton(
              onPressed: null,
              child: Text(appLocalizations.generalSelectAll),
            );
          }
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
