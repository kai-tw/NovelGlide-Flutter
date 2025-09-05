import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/shared_bottom_container.dart';
import 'cubit/download_manager_task_list_cubit.dart';
import 'task_list/download_manager_task_list.dart';

class DownloadManagerScaffold extends StatelessWidget {
  const DownloadManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DownloadManagerTaskListCubit cubit =
        BlocProvider.of<DownloadManagerTaskListCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.generalDownload(2)),
      ),
      body: const SafeArea(
        child: DownloadManagerTaskList(),
      ),
      bottomNavigationBar: SharedBottomContainer(
        child: OverflowBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: cubit.clearTasks,
              icon: const Icon(Icons.cleaning_services_rounded),
              label: Text(appLocalizations.generalClear),
            ),
          ],
        ),
      ),
    );
  }
}
