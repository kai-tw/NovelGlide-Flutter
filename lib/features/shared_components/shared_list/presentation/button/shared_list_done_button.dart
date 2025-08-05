part of '../../shared_list.dart';

class SharedListDoneButton<T extends SharedListCubit<dynamic>>
    extends StatelessWidget {
  const SharedListDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final T cubit = BlocProvider.of<T>(context);
    return BlocBuilder<T, SharedListState<dynamic>>(
      buildWhen: (SharedListState<dynamic> previous,
              SharedListState<dynamic> current) =>
          previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, SharedListState<dynamic> state) {
        Widget? child;

        if (state.isSelecting) {
          child = TextButton(
            onPressed: () => cubit.isSelecting = false,
            child: Text(appLocalizations.generalDone),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
