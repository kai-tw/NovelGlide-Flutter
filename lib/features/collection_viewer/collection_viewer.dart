import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../data_model/collection_data.dart';
import '../../enum/loading_state_code.dart';
import '../../repository/book_repository.dart';
import '../../repository/collection_repository.dart';
import '../../utils/route_utils.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_list/list_template.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../table_of_contents/table_of_contents.dart';

part 'bloc/cubit.dart';
part 'widgets/list_item.dart';
part 'widgets/list_view.dart';
part 'widgets/popup_menu_button.dart';

class CollectionViewer extends StatelessWidget {
  final CollectionData collectionData;

  const CollectionViewer({super.key, required this.collectionData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _Cubit(collectionData),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(collectionData.name),
          actions: const [
            CommonListSelectAllButton<_Cubit, BookData>(),
            CommonListDoneButton<_Cubit, BookData>(),
            _PopupMenuButton(),
          ],
        ),
        body: const SafeArea(
          child: _ListView(),
        ),
      ),
    );
  }
}
