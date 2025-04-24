import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../data_model/collection_data.dart';
import '../../enum/loading_state_code.dart';
import '../../utils/route_utils.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_list/list_template.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../table_of_contents/table_of_contents.dart';
import 'cubit/collection_viewer_cubit.dart';

part 'widgets/collection_viewer_list_item.dart';
part 'widgets/collection_viewer_list_view.dart';
part 'widgets/collection_viewer_menu_button.dart';

class CollectionViewer extends StatelessWidget {
  const CollectionViewer({super.key, required this.collectionData});

  final CollectionData collectionData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CollectionViewerCubit>(
      create: (_) => CollectionViewerCubit(collectionData),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(collectionData.name),
          actions: const <Widget>[
            CommonListSelectAllButton<CollectionViewerCubit, BookData>(),
            CommonListDoneButton<CollectionViewerCubit, BookData>(),
            CollectionViewerMenuButton(),
          ],
        ),
        body: const SafeArea(
          child: CollectionViewerListView(),
        ),
      ),
    );
  }
}
