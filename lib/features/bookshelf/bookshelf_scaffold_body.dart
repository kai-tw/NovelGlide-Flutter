part of 'bookshelf.dart';

class BookshelfScaffoldBody extends StatelessWidget {
  const BookshelfScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return Column(
      children: <Widget>[
        const Advertisement(adType: AdvertisementType.bookshelf),
        const BookshelfLoadingIndicator(),
        Expanded(
          child: PageStorage(
            bucket: homepageCubit.bookshelfBucket,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              notificationPredicate: (_) => cubit.state.canRefresh,
              child: const Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>('homepage-bookshelf'),
                  slivers: <Widget>[
                    Bookshelf(),
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
