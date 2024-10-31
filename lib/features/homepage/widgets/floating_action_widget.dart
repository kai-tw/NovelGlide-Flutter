part of '../homepage.dart';

class _FloatingActionWidget extends StatelessWidget {
  const _FloatingActionWidget();

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass =
        WindowClass.fromWidth(MediaQuery.of(context).size.width);
    double maxWidth =
        MediaQuery.of(context).size.width - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kFloatingActionButtonMargin),
              child: BlocBuilder<HomepageCubit, _HomepageState>(
                buildWhen: (previous, current) =>
                    previous.navItem != current.navItem,
                builder: (context, state) {
                  switch (state.navItem) {
                    case HomepageNavigationItem.bookshelf:
                      return const BookshelfOperationPanel();

                    case HomepageNavigationItem.collection:
                      return const CollectionListOperationPanel();

                    case HomepageNavigationItem.bookmark:
                      return const BookmarkListOperationPanel();

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          const _FloatingActionButton(),
        ],
      ),
    );
  }
}
