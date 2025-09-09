import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../../books/domain/entities/book.dart';
import 'cubit/collection_add_book_cubit.dart';
import 'widgets/collection_add_book_list.dart';
import 'widgets/collection_add_book_navigation.dart';

class CollectionAddBookScaffold extends StatelessWidget {
  const CollectionAddBookScaffold({super.key, required this.dataSet});

  final Set<Book> dataSet;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider<CollectionAddBookCubit>(
      create: (_) => sl<CollectionAddBookCubit>()..init(dataSet),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.collectionAddToCollections),
        ),
        body: const SafeArea(
          child: CollectionAddBookList(),
        ),
        bottomNavigationBar: const CollectionAddBookNavigation(),
      ),
    );
  }
}
