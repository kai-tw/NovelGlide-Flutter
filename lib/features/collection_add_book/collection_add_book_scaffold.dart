import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../data_model/book_data.dart';
import '../../data_model/collection_data.dart';
import '../../enum/loading_state_code.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../repository/collection_repository.dart';
import '../collection_add/collection_add_dialog.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';

part 'bloc/cubit.dart';
part 'widgets/list_view.dart';
part 'widgets/navigation.dart';

class CollectionAddBookScaffold extends StatelessWidget {
  final Set<BookData> dataSet;

  const CollectionAddBookScaffold({super.key, required this.dataSet});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => _Cubit(dataSet),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
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
