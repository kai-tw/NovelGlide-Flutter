import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/features/bookshelf/sliver_app_bar_selecting.dart';
import 'package:novelglide/features/bookshelf/sliver_loading.dart';

import '../../shared/book_process.dart';
import '../../shared/emoticon_collection.dart';
import '../table_of_contents/index.dart';
import 'bloc/bookshelf_bloc.dart';
import 'sliver_app_bar_default.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: BlocBuilder<BookshelfCubit, BookshelfState>(
        builder: _listWidget,
      ),
    );
  }

  Widget _listWidget(BuildContext context, BookshelfState state) {
    List<Widget> sliverList = [];

    switch (state.code) {
      case BookshelfStateCode.selecting:
        sliverList.add(const BookshelfSliverAppBarSelecting());
        break;
      default:
        sliverList.add(const BookshelfSliverAppBarDefault());
    }

    final String randomEmoticon = EmoticonCollection.getRandomShock();
    switch (state.code) {
      case BookshelfStateCode.unload:
        BlocProvider.of<BookshelfCubit>(context).refresh();
        break;
      case BookshelfStateCode.loading:
        sliverList.add(const BookshelfSliverLoading());
        break;
      case BookshelfStateCode.empty:
        sliverList.add(SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(randomEmoticon),
                Text(AppLocalizations.of(context)!.empty),
              ],
            ),
          ),
        ));
        break;
      case BookshelfStateCode.normal:
      case BookshelfStateCode.selecting:
        sliverList.add(SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.0,
            childAspectRatio: 150 / 330,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _bookWidget(context, state.bookList[index]);
            },
            childCount: state.bookList.length,
          ),
        ));
        break;
    }

    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<BookshelfCubit>(context).refresh(),
      child: CustomScrollView(slivers: sliverList),
    );
  }

  Widget _bookWidget(BuildContext context, BookObject bookObject) {
    BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    BookshelfState state = cubit.state;
    final bool isSelected = state.selectedSet.contains(bookObject.name);
    return GestureDetector(
      onTap: () {
        switch (state.code) {
          case BookshelfStateCode.selecting:
            if (isSelected) {
              cubit.removeSelect(bookObject.name);
            } else {
              cubit.addSelect(bookObject.name);
            }
            break;
          case BookshelfStateCode.normal:
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => TableOfContents(bookObject),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return child;
              },
            ));
          default:
        }
      },
      onLongPress: () {
        switch (state.code) {
          case BookshelfStateCode.normal:
          case BookshelfStateCode.selecting:
            cubit.addSelect(bookObject.name);
            break;
          default:
        }
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8.0),
        height: 350.0,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: isSelected ? Theme.of(context).colorScheme.surfaceVariant : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AspectRatio(
                  aspectRatio: 1 / 1.5,
                  child: Hero(
                    tag: bookObject,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: bookObject.getCover(),
                    ),
                  ),
                ),
              ),
              Text(
                bookObject.name,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
