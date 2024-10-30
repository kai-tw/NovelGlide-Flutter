import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../book_add/book_add_dialog.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../collection_add/collection_add_dialog.dart';
import '../collection_list/bloc/collection_list_bloc.dart';
import 'bloc/homepage_bloc.dart';

class HomepageFloatingActionButton extends StatelessWidget {
  const HomepageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final collectionListCubit = BlocProvider.of<CollectionListCubit>(context);

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        Widget? child;

        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            child = FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const BookAddDialog(),
                ).then((isSuccess) {
                  if (isSuccess == true) {
                    bookshelfCubit.refresh();
                  }
                });
              },
              child: Icon(
                Icons.add,
                semanticLabel: appLocalizations.accessibilityAddBookButton,
              ),
            );
            break;

          case HomepageNavigationItem.collection:
            child = FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const CollectionAddDialog(),
                ).then((_) {
                  collectionListCubit.refresh();
                });
              },
              child: Icon(
                Icons.add,
                semanticLabel: appLocalizations.collectionAddBtn,
              ),
            );
            break;

          default:
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(2.0, 0.0),
                end: const Offset(0.0, 0.0),
              )
                  .chain(CurveTween(curve: Curves.easeInOutCubicEmphasized))
                  .animate(animation),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
