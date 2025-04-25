part of 'bookmark_list.dart';

class BookmarkListScaffoldBody extends StatelessWidget {
  const BookmarkListScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return Column(
      children: <Widget>[
        /// Ad goes here
        Expanded(
          child: PageStorage(
            bucket: homepageCubit.bookmarkBucket,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              child: const Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>('homepage-bookmark'),
                  slivers: <Widget>[
                    BookmarkList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
