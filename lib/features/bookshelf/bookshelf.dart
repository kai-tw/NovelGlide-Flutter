import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_process.dart';
import '../../shared/emoticon_collection.dart';
import 'bloc/bookshelf_bloc.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: BlocProvider(
        create: (_) => BookshelfCubit(),
        child: BlocBuilder<BookshelfCubit, BookshelfState>(
          builder: _listWidget,
        ),
      ),
    );
  }

  Widget _listWidget(BuildContext context, BookshelfState state) {
    List<Widget> sliverList = [];

    final bool isSelectedAll = state.selectedSet.length == state.bookList.length;
    switch (state.code) {
      case BookshelfStateCode.selecting:
        sliverList.add(SliverAppBar(
          leading: IconButton(
            onPressed: () {
              if (isSelectedAll) {
                BlocProvider.of<BookshelfCubit>(context).clearSelect();
              } else {
                BlocProvider.of<BookshelfCubit>(context).allSelect();
              }
            },
            icon: Icon(isSelectedAll ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(state.selectedSet.length.toString()),
          ),
        ));
        break;
      default:
        sliverList.add(SliverAppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.app_name),
          ),
        ));
    }

    final String randomEmoticon = EmoticonCollection.getRandomShock();
    switch (state.code) {
      case BookshelfStateCode.unload:
        BlocProvider.of<BookshelfCubit>(context).refresh();
        break;
      case BookshelfStateCode.loading:
        sliverList.add(SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(randomEmoticon),
                Text(AppLocalizations.of(context)!.loading),
              ],
            ),
          ),
        ));
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
          // TODO OPEN MODE.
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: _getCover(bookObject),
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

  Widget _getCover(BookObject bookObject) {
    if (bookObject.coverFile!.existsSync()) {
      return Image.file(
        bookObject.coverFile!,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        BookProcess.defaultCover,
        fit: BoxFit.cover,
      );
    }
  }
}
