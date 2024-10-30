import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data_model/book_data.dart';
import '../../utils/route_utils.dart';
import '../common_components/common_error_dialog.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'widgets/bookshelf_book_widget.dart';
import 'widgets/bookshelf_draggable_book.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return InkWell(
      onTap: () {
        if (cubit.state.isSelecting) {
          _onTap(cubit, bookData);
        } else {
          if (bookData.isExist) {
            Navigator.of(context)
                .push(RouteUtils.pushRoute(TableOfContents(bookData)));
          } else {
            showDialog(
              context: context,
              // TODO: Localize
              builder: (context) => const CommonErrorDialog(
                content: "This book doesn't exist.",
              ),
            ).then((_) => cubit.refresh());
          }
        }
      },
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          BlocBuilder<BookshelfCubit, BookshelfState>(
            buildWhen: (previous, current) =>
                previous.isSelecting != current.isSelecting,
            builder: (context, state) {
              if (state.isSelecting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BookshelfBookWidget(bookData: bookData),
                );
              } else {
                return Semantics(
                  label: appLocalizations.accessibilityBookshelfListItem,
                  onTapHint:
                      appLocalizations.accessibilityBookshelfListItemOnTap,
                  onLongPressHint: appLocalizations
                      .accessibilityBookshelfListItemOnLongPress,
                  child: BookshelfDraggableBook(bookData),
                );
              }
            },
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: BlocBuilder<BookshelfCubit, BookshelfState>(
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
}

class _Checkbox extends StatelessWidget {
  final BookData bookData;

  const _Checkbox({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) =>
          previous.selectedBooks != current.selectedBooks,
      builder: (context, state) {
        return Checkbox(
          value: state.selectedBooks.contains(bookData),
          onChanged: (_) => _onTap(cubit, bookData),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          semanticLabel: appLocalizations.bookshelfAccessibilityCheckbox,
        );
      },
    );
  }
}

void _onTap(BookshelfCubit cubit, BookData bookData) {
  if (cubit.state.selectedBooks.contains(bookData)) {
    cubit.deselectBook(bookData);
  } else {
    cubit.selectBook(bookData);
  }
}
