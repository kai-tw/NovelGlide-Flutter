import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import 'bloc/toc_collection_bloc.dart';
import 'toc_collection_list.dart';
import 'toc_collection_navigation.dart';

class TocCollectionScaffold extends StatelessWidget {
  final BookData bookData;

  const TocCollectionScaffold({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => TocCollectionCubit(bookData),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.collectionAddToCollections),
        ),
        body: const SafeArea(
          child: TocCollectionList(),
        ),
        bottomNavigationBar: const TocCollectionNavigation(),
      ),
    );
  }
}
