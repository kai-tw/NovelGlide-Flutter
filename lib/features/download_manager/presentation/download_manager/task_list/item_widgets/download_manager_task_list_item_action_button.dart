import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../../domain/entities/downloader_task_state.dart';
import '../../cubit/download_manager_task_list_item_cubit.dart';
import '../../cubit/download_manager_task_list_item_state.dart';

class DownloadManagerTaskListItemActionButton extends StatelessWidget {
  const DownloadManagerTaskListItemActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DownloadManagerTaskListItemCubit cubit =
        BlocProvider.of<DownloadManagerTaskListItemCubit>(context);

    return BlocBuilder<DownloadManagerTaskListItemCubit,
        DownloadManagerTaskListItemState>(
      buildWhen: (DownloadManagerTaskListItemState previous,
              DownloadManagerTaskListItemState current) =>
          previous.stateCode != current.stateCode ||
          previous.progress != current.progress,
      builder: (BuildContext context, DownloadManagerTaskListItemState state) {
        switch (state.stateCode) {
          case DownloaderTaskState.initial:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: CircularProgressIndicator(),
              ),
            );

          case DownloaderTaskState.downloading:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        value: state.progress,
                        semanticsLabel: appLocalizations.generalDownloading,
                        semanticsValue: state.progress == null
                            ? appLocalizations.generalLoading
                            : '${state.progress! * 100}%',
                      ),
                    ),
                    Positioned.fill(
                      child: IconButton(
                        onPressed: cubit.cancelTask,
                        icon: const Icon(Icons.stop),
                        tooltip: appLocalizations.generalCancel,
                      ),
                    ),
                  ],
                ),
              ),
            );

          case DownloaderTaskState.pending:
          case DownloaderTaskState.canceled:
          case DownloaderTaskState.error:
            return IconButton(
              onPressed: cubit.removeTask,
              icon: const Icon(Icons.delete_rounded),
              tooltip: appLocalizations.generalDelete,
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
