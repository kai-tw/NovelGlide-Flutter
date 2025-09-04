import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/downloader_task_state.dart';
import '../../cubit/download_manager_task_list_item_cubit.dart';
import '../../cubit/download_manager_task_list_item_state.dart';

class DownloadManagerTaskListItemProgressBar extends StatelessWidget {
  const DownloadManagerTaskListItemProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final DownloadManagerTaskListItemCubit cubit =
        BlocProvider.of<DownloadManagerTaskListItemCubit>(context);

    return BlocBuilder<DownloadManagerTaskListItemCubit,
        DownloadManagerTaskListItemState>(
      buildWhen: (DownloadManagerTaskListItemState previous,
              DownloadManagerTaskListItemState current) =>
          previous.stateCode != current.stateCode ||
          previous.progress != current.progress,
      builder: (BuildContext context, DownloadManagerTaskListItemState state) {
        if (state.stateCode == DownloaderTaskState.downloading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CircularProgressIndicator.adaptive(
                      value: state.progress,
                    ),
                  ),
                  Positioned.fill(
                    child: IconButton(
                      onPressed: cubit.cancelTask,
                      icon: const Icon(Icons.stop),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
