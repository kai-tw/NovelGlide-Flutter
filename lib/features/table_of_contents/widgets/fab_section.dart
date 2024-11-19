part of '../table_of_contents.dart';

class _FabSection extends StatelessWidget {
  const _FabSection();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);
    double maxWidth = windowWidth - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      padding: const EdgeInsets.only(left: kFloatingActionButtonMargin),
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: BlocBuilder<_Cubit, _State>(
        builder: (BuildContext context, _State state) {
          List<Widget> children = [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(RouteUtils.pushRoute(
                      ReaderWidget(
                        bookPath: cubit.bookData.absoluteFilePath,
                        bookData: cubit.bookData,
                      ),
                    ))
                    .then((_) => cubit.refresh());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                fixedSize: const Size.fromHeight(56.0),
                elevation: 5.0,
              ),
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(AppLocalizations.of(context)!.tocStartReading),
            )
          ];

          if (state.bookmarkData != null) {
            children.add(Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(RouteUtils.pushRoute(
                        ReaderWidget(
                          bookPath: cubit.bookData.absoluteFilePath,
                          bookData: cubit.bookData,
                          isGotoBookmark: true,
                        ),
                      ))
                      .then((_) => cubit.refresh());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  fixedSize: const Size.fromHeight(56.0),
                  elevation: 5.0,
                ),
                icon: const Icon(Icons.bookmark_rounded),
                label: Text(AppLocalizations.of(context)!.tocContinueReading),
              ),
            ));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
