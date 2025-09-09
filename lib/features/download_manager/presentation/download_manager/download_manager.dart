import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'cubit/download_manager_task_list_cubit.dart';
import 'download_manager_scaffold.dart';

class DownloadManager extends StatelessWidget {
  const DownloadManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadManagerTaskListCubit>(
      create: (_) => sl<DownloadManagerTaskListCubit>()..getTaskList(),
      child: const DownloadManagerScaffold(),
    );
  }
}
