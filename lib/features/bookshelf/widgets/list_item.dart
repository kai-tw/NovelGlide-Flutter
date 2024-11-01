part of '../bookshelf.dart';

class _SliverListItem extends StatelessWidget {
  const _SliverListItem(this.bookData);

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookshelfCubit>(context);

    return InkWell(
      onTap: () {
        if (cubit.state.isSelecting) {
          onTap(cubit, bookData);
        } else {
          if (bookData.isExist) {
            Navigator.of(context)
                .push(RouteUtils.pushRoute(TableOfContents(bookData)));
          } else {
            showDialog(
              context: context,
              builder: (context) => CommonErrorDialog(
                content: appLocalizations.bookshelfBookNotExist,
              ),
            ).then((_) => cubit.refresh());
          }
        }
      },
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          BlocBuilder<BookshelfCubit, _State>(
            buildWhen: (previous, current) =>
                previous.isSelecting != current.isSelecting,
            builder: (context, state) {
              if (state.isSelecting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _BookWidget(bookData: bookData),
                );
              } else {
                return Semantics(
                  label: appLocalizations.accessibilityBookshelfListItem,
                  onTapHint:
                      appLocalizations.accessibilityBookshelfListItemOnTap,
                  onLongPressHint: appLocalizations
                      .accessibilityBookshelfListItemOnLongPress,
                  child: _DraggableBook(bookData),
                );
              }
            },
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: BlocBuilder<BookshelfCubit, _State>(
              buildWhen: (previous, current) =>
                  previous.isSelecting != current.isSelecting,
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child:
                      state.isSelecting ? _Checkbox(bookData: bookData) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static void onTap(BookshelfCubit cubit, BookData bookData) {
    if (cubit.state.selectedBooks.contains(bookData)) {
      cubit.deselectBook(bookData);
    } else {
      cubit.selectBook(bookData);
    }
  }
}

class _Checkbox extends StatelessWidget {
  final BookData bookData;

  const _Checkbox({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, _State>(
      buildWhen: (previous, current) =>
          previous.selectedBooks != current.selectedBooks,
      builder: (context, state) {
        return Checkbox(
          value: state.selectedBooks.contains(bookData),
          onChanged: (_) => _SliverListItem.onTap(cubit, bookData),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          semanticLabel: appLocalizations.bookshelfAccessibilityCheckbox,
        );
      },
    );
  }
}
