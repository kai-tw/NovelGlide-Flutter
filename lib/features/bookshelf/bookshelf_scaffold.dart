import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../add_book/add_book_scaffold.dart';
import '../common_components/common_add_floating_action_button.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_app_bar.dart';
import 'bookshelf_sliver_list.dart';

class BookshelfScaffold extends StatelessWidget {
  const BookshelfScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context)..refresh();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const BookshelfAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => cubit.refresh(),
        child: const CustomScrollView(
          slivers: [
            BookshelfSliverList(),
          ],
        ),
      ),
      floatingActionButton: CommonAddFloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) => const AddBookScaffold()))
              .then((isSuccess) => _onPopBack(context, isSuccess));
        },
      ),
    );
  }

  void _onPopBack(BuildContext context, bool? isSuccess) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (isSuccess == true) {
      cubit.refresh();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addWhatSuccessfully(appLocalizations.book)),
      ));
    } else if (isSuccess == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addWhatFailed(appLocalizations.book)),
      ));
    }
  }
}
