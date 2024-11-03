part of '../list_template.dart';

class HomepageListSelectButton<M extends HomepageListCubit<T>, T>
    extends StatelessWidget {
  const HomepageListSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<M>(context);
    return BlocBuilder<M, HomepageListState<T>>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.dataList.isNotEmpty != current.dataList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          final appLocalizations = AppLocalizations.of(context)!;
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
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
