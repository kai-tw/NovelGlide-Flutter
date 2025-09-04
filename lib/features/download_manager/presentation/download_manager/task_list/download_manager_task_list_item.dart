import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../cubit/download_manager_task_list_item_cubit.dart';
import 'item_widgets/download_manager_task_list_item_icon.dart';
import 'item_widgets/download_manager_task_list_item_progress_bar.dart';
import 'item_widgets/download_manager_task_list_item_title.dart';

class DownloadManagerTaskListItem extends StatelessWidget {
  const DownloadManagerTaskListItem({
    super.key,
    required this.identifier,
  });

  final String identifier;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadManagerTaskListItemCubit>(
      create: (_) => sl<DownloadManagerTaskListItemCubit>()..init(identifier),
      child: const ListTile(
        leading: DownloaderManagerTaskListItemIcon(),
        title: DownloadManagerTaskListItemTitle(),
        trailing: DownloadManagerTaskListItemProgressBar(),
      ),
    );
  }
}
