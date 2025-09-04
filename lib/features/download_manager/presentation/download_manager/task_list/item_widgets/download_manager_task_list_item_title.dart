import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/download_manager_task_list_item_cubit.dart';
import '../../cubit/download_manager_task_list_item_state.dart';

class DownloadManagerTaskListItemTitle extends StatelessWidget {
  const DownloadManagerTaskListItemTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadManagerTaskListItemCubit,
        DownloadManagerTaskListItemState>(
      buildWhen: (DownloadManagerTaskListItemState previous,
              DownloadManagerTaskListItemState current) =>
          previous.fileName != current.fileName,
      builder: (BuildContext context, DownloadManagerTaskListItemState state) {
        return Text(state.fileName);
      },
    );
  }
}
