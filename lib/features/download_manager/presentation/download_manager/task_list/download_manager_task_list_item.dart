import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../domain/entities/downloader_task_state.dart';
import '../cubit/download_manager_task_list_item_cubit.dart';
import '../cubit/download_manager_task_list_item_state.dart';

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
      child: ListTile(
        leading: _buildIcon(context),
        title: _buildTitle(context),
        subtitle: _buildProgressBar(context),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
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

  Widget _buildTitle(BuildContext context) {
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

  Widget _buildProgressBar(BuildContext context) {
    return BlocBuilder<DownloadManagerTaskListItemCubit,
        DownloadManagerTaskListItemState>(
      buildWhen: (DownloadManagerTaskListItemState previous,
              DownloadManagerTaskListItemState current) =>
          previous.stateCode != current.stateCode ||
          previous.progress != current.progress,
      builder: (BuildContext context, DownloadManagerTaskListItemState state) {
        if (state.stateCode == DownloaderTaskState.downloading) {
          return LinearProgressIndicator(
            value: state.progress,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
