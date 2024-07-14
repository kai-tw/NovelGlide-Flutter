import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
import '../book_importer/book_importer_scaffold.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import 'bloc/navigation_bloc.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        switch (state.navItem) {
          case NavigationItem.bookshelf:
            return AppBar(
              leading: const Icon(Icons.book_outlined),
              title: Text(appLocalizations.titleBookshelf),
              actions: [
                IconButton(
                  onPressed: () => _navigateToImportBook(context).then((isSuccess) => _onPopBack(context, isSuccess)),
                  icon: const Icon(Icons.save_alt_rounded),
                  tooltip: AppLocalizations.of(context)!.bookImporter,
                ),
              ],
            );
          case NavigationItem.bookmark:
            return AppBar(
              leading: const Icon(Icons.bookmark_outline_rounded),
              title: Text(AppLocalizations.of(context)!.titleBookmarks),
            );
          case NavigationItem.settings:
            return AppBar(
              leading: const Icon(Icons.settings_outlined),
              title: Text(AppLocalizations.of(context)!.titleSettings),
            );
        }
      },
    );
  }

  /// Based on the window size, navigate to the import book page
  Future<dynamic> _navigateToImportBook(BuildContext context) async {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    switch (windowClass) {
      /// Push to the import book page
      case WindowClass.compact:
        return Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookImporterScaffold()));

      /// Show in a dialog
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Dialog(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 360.0,
                child: BookImporterScaffold(),
              ),
            );
          },
        );
    }
  }

  /// Handle the result of importing a book
  void _onPopBack(BuildContext context, dynamic isSuccess) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (isSuccess == true) {
      BlocProvider.of<BookshelfCubit>(context).refresh();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.importSuccessfully),
      ));
    } else if (isSuccess == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.importFailed),
      ));
    }
  }
}