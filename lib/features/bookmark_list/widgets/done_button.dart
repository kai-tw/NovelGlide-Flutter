part of '../bookmark_list.dart';

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = TextButton(
            onPressed: () => cubit.setSelecting(false),
            child: Text(appLocalizations.generalDone),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
      },
    );
  }
}
