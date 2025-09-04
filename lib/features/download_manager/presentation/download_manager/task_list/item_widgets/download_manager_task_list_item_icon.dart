import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/downloader_task_state.dart';
import '../../cubit/download_manager_task_list_item_cubit.dart';
import '../../cubit/download_manager_task_list_item_state.dart';

class DownloaderManagerTaskListItemIcon extends StatelessWidget {
  const DownloaderManagerTaskListItemIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadManagerTaskListItemCubit,
        DownloadManagerTaskListItemState>(
      buildWhen: (DownloadManagerTaskListItemState previous,
              DownloadManagerTaskListItemState current) =>
          previous.stateCode != current.stateCode,
      builder: (BuildContext context, DownloadManagerTaskListItemState state) {
        return Icon(
          switch (state.stateCode) {
            DownloaderTaskState.initial => Icons.pending_actions_rounded,
            DownloaderTaskState.downloading => Icons.downloading_rounded,
            DownloaderTaskState.success => Icons.check_rounded,
            DownloaderTaskState.error => Icons.error_outline_rounded,
          },
          color: switch (state.stateCode) {
            DownloaderTaskState.initial => null,
            DownloaderTaskState.downloading => null,
            DownloaderTaskState.success =>
              Theme.of(context).colorScheme.primary,
            DownloaderTaskState.error => Theme.of(context).colorScheme.error,
          },
        );
      },
    );
  }
}
