import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../../enum/window_class.dart';
import '../common_components/common_back_button.dart';
import 'bloc/toc_collection_dialog_bloc.dart';
import 'toc_collection_dialog_list.dart';
import 'toc_collection_dialog_navigation.dart';

class TocCollectionDialog extends StatelessWidget {
  final BookData bookData;

  const TocCollectionDialog({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => TocCollectionDialogCubit(bookData)..init(),
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        child: Container(
          constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
          child: Scaffold(
            appBar: AppBar(
              leading: const CommonBackButton(),
              title: Text(appLocalizations.collectionAddToCollections),
            ),
            body: const TocCollectionDialogList(),
            bottomNavigationBar: const TocCollectionDialogNavigation(),
          ),
        ),
      ),
    );
  }
}