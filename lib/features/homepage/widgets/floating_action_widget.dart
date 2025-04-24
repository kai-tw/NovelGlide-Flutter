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
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kFloatingActionButtonMargin,
              ),
              child: BlocBuilder<HomepageCubit, _HomepageState>(
                buildWhen: (_HomepageState previous, _HomepageState current) =>
                    previous.navItem != current.navItem,
                builder: (BuildContext context, _HomepageState state) {
                  switch (state.navItem) {
                    case HomepageNavigationItem.bookshelf:
                      return const _DeleteDragTarget<BookshelfCubit,
                          BookData>();

                    case HomepageNavigationItem.collection:
                      return const _DeleteDragTarget<CollectionListCubit,
                          CollectionData>();

                    case HomepageNavigationItem.bookmark:
                      return const _DeleteDragTarget<BookmarkListCubit,
                          BookmarkData>();

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
