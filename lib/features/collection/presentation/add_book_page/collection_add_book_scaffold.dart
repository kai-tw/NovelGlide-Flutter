import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../core/shared_components/common_loading.dart';
import '../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../book_service/book_service.dart';
import '../../collection_service.dart';
import '../add_dialog/collection_add_dialog.dart';

part 'cubit/collection_add_book_cubit.dart';
part 'cubit/collection_add_book_state.dart';
part 'widgets/list_view.dart';
part 'widgets/navigation.dart';

class CollectionAddBookScaffold extends StatelessWidget {
  const CollectionAddBookScaffold({super.key, required this.dataSet});

  final Set<BookData> dataSet;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider<CollectionAddBookCubit>(
      create: (_) => CollectionAddBookCubit(dataSet),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.collectionAddToCollections),
        ),
        body: const SafeArea(
          child: _ListView(),
        ),
        bottomNavigationBar: const _Navigation(),
      ),
    );
  }
}
