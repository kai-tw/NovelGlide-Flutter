part of '../homepage.dart';

class _FloatingActionWidget extends StatelessWidget {
  const _FloatingActionWidget();

  @override
  Widget build(BuildContext context) {
    final WindowSize windowClass =
        WindowSize.fromWidth(MediaQuery.sizeOf(context).width);
    double maxWidth =
        MediaQuery.sizeOf(context).width - kFloatingActionButtonMargin;

    if (windowClass != WindowSize.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: BlocBuilder<HomepageCubit, HomepageState>(
              buildWhen: (HomepageState previous, HomepageState current) =>
                  previous.navItem != current.navItem,
              builder: (BuildContext context, HomepageState state) {
                switch (state.navItem) {
                  case HomepageNavigationItem.bookshelf:
                    return const Padding(
                      padding: EdgeInsets.only(
                        left: kFloatingActionButtonMargin,
                        right: kFloatingActionButtonMargin,
                      ),
                      child: _DeleteDragTarget<BookListCubit, Book>(),
                    );

                  case HomepageNavigationItem.collection:
                    return const Padding(
                      padding: EdgeInsets.only(
                        left: kFloatingActionButtonMargin,
                        right: kFloatingActionButtonMargin,
                      ),
                      child: _DeleteDragTarget<CollectionListCubit,
                          CollectionData>(),
                    );

                  case HomepageNavigationItem.bookmark:
                    return const Padding(
                      padding: EdgeInsets.only(
                        left: kFloatingActionButtonMargin,
                      ),
                      child:
                          _DeleteDragTarget<BookmarkListCubit, BookmarkData>(),
                    );

                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
          const _FloatingActionButton(),
        ],
      ),
    );
  }
}
