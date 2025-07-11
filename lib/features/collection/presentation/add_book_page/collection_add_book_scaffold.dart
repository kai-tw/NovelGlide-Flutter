import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../core/shared_components/common_loading.dart';
import '../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../book_service/data/model/book_data.dart';
import '../../data/collection_data.dart';
import '../../data/collection_repository.dart';
import '../add_dialog/collection_add_dialog.dart';

part 'cubit/cubit.dart';
part 'widgets/list_view.dart';
part 'widgets/navigation.dart';

class CollectionAddBookScaffold extends StatelessWidget {
  const CollectionAddBookScaffold({super.key, required this.dataSet});

  final Set<BookData> dataSet;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider<_Cubit>(
      create: (_) => _Cubit(dataSet),
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
