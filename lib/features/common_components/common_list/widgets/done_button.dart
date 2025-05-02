part of '../list_template.dart';

class CommonListDoneButton<M extends CommonListCubit<T>, T>
    extends StatelessWidget {
  const CommonListDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final M cubit = BlocProvider.of<M>(context);
    return BlocBuilder<M, CommonListState<T>>(
      buildWhen: (CommonListState<T> previous, CommonListState<T> current) =>
          previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, CommonListState<T> state) {
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
