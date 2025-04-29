part of '../bookshelf.dart';

class _SliverListItem extends StatelessWidget {
  const _SliverListItem(this.bookData);

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: <Widget>[
          // Book widget
          BlocBuilder<BookshelfCubit, BookShelfState>(
            buildWhen: (BookShelfState previous, BookShelfState current) =>
                previous.code != current.code ||
                previous.isSelecting != current.isSelecting ||
                previous.isDragging != current.isDragging,
            builder: _bookWidgetBuilder,
          ),

          // Checkbox
          Positioned(
            top: 16.0,
            left: 16.0,
            child: BlocBuilder<BookshelfCubit, BookShelfState>(
              buildWhen: (BookShelfState previous, BookShelfState current) =>
                  previous.isSelecting != current.isSelecting ||
                  previous.selectedSet != current.selectedSet,
              builder: _checkboxWidgetBuilder,
            ),
          ),
        ],
      ),
    );
  }

  /// *************************************************************************
  /// Builders
  /// *************************************************************************

  /// Book widgets builder
  Widget _bookWidgetBuilder(BuildContext context, BookShelfState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (state.isSelecting || state.code.isBackgroundLoading) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: _BookWidget(bookData: bookData),
      );
    } else {
      return Semantics(
        label: appLocalizations.accessibilityBookshelfListItem,
        onTapHint: appLocalizations.accessibilityBookshelfListItemOnTap,
        onLongPressHint:
            appLocalizations.accessibilityBookshelfListItemOnLongPress,
        child: _DraggableBook(
          bookData: bookData,
          isDraggable: !state.isDragging,
        ),
      );
    }
  }

  /// Checkbox widgets builder
  Widget _checkboxWidgetBuilder(
    BuildContext context,
    BookShelfState state,
  ) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    Widget? checkboxWidget;

    if (state.isSelecting) {
      checkboxWidget = Checkbox(
        value: state.selectedSet.contains(bookData),
        onChanged: (_) => _selectionTap(cubit, bookData),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        semanticLabel: appLocalizations.bookshelfAccessibilityCheckbox,
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: checkboxWidget,
    );
  }

  /// *************************************************************************
  /// Tapping Logic
  /// *************************************************************************

  /// Tap
  void _onTap(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    if (cubit.state.isSelecting) {
      _selectionTap(cubit, bookData);
    } else if (bookData.isExist) {
      // Navigate to the table of contents page.
      Navigator.of(context)
          .push(RouteUtils.pushRoute(TableOfContents(bookData)));
    } else {
      // Show the book is not exist dialog.
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonErrorDialog(
          content: appLocalizations.bookshelfBookNotExist,
        ),
      ).then((_) => cubit.refresh());
    }
  }

  /// Address the book selection.
  void _selectionTap(BookshelfCubit cubit, BookData bookData) {
    if (cubit.state.selectedSet.contains(bookData)) {
      cubit.deselectSingle(bookData);
    } else {
      cubit.selectSingle(bookData);
    }
  }
}
