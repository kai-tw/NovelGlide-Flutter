import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared_components/shared_bottom_container.dart';
import 'cubit/download_manager_task_list_cubit.dart';
import 'task_list/download_manager_task_list.dart';

class DownloadManagerScaffold extends StatelessWidget {
  const DownloadManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final DownloadManagerTaskListCubit cubit =
        BlocProvider.of<DownloadManagerTaskListCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Manager'),
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
              label: const Text('Clear'),
            ),
            TextButton.icon(
              onPressed: cubit.createMockTask,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Mock DL'),
            ),
          ],
        ),
      ),
    );
  }
}
