import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_components/common_delete_dialog.dart';
import '../../../../core/shared_components/common_loading.dart';
import '../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../core/utils/popup_menu_utils.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../book/data/model/book_data.dart';
import '../../../book/presentation/table_of_contents_page/table_of_contents.dart';
import '../../data/collection_data.dart';
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
          title: Text(collectionData.name),
          actions: const <Widget>[
            SharedListSelectAllButton<CollectionViewerCubit>(),
            SharedListDoneButton<CollectionViewerCubit>(),
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
