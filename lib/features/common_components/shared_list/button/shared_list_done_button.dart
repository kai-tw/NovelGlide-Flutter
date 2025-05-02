part of '../shared_list.dart';

class SharedListDoneButton<M extends SharedListCubit<T>, T>
    extends StatelessWidget {
  const SharedListDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final M cubit = BlocProvider.of<M>(context);
    return BlocBuilder<M, SharedListState<T>>(
      buildWhen: (SharedListState<T> previous, SharedListState<T> current) =>
          previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, SharedListState<T> state) {
        Widget? child;

        if (state.isSelecting) {
          child = TextButton(
            onPressed: () => cubit.isSelecting = false,
            child: Text(appLocalizations.generalDone),
          );
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
