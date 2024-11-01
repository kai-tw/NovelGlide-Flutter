part of 'collection_list.dart';

class CollectionListOperationPanel extends StatelessWidget {
  const CollectionListOperationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedCollections != current.selectedCollections,
      builder: (context, state) {
        Widget child = const SizedBox.shrink();

        if (state.isSelecting && state.selectedCollections.isNotEmpty) {
          child = const _DeleteButton();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 3.0),
                end: const Offset(0.0, 0.0),
              )
                  .chain(CurveTween(curve: Curves.easeInOutCubicEmphasized))
                  .animate(animation),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
