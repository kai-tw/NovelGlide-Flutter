import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../cubit/download_manager_task_list_cubit.dart';
import '../cubit/download_manager_task_list_state.dart';
import 'download_manager_task_list_item.dart';

class DownloadManagerTaskList extends StatelessWidget {
  const DownloadManagerTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final DownloadManagerTaskListCubit cubit =
        BlocProvider.of<DownloadManagerTaskListCubit>(context);
    return BlocBuilder<DownloadManagerTaskListCubit,
        DownloadManagerTaskListState>(
      builder: (BuildContext context, DownloadManagerTaskListState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonLoadingWidget();

          case LoadingStateCode.error:
            return const CommonErrorWidget();

          case LoadingStateCode.loaded:
            if (state.identifierList.isEmpty) {
              return const SharedListEmpty();
            } else {
              return Scrollbar(
                child: RefreshIndicator(
                  onRefresh: cubit.getTaskList,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return DownloadManagerTaskListItem(
                        identifier: state.identifierList[index],
                      );
                    },
                    itemCount: state.identifierList.length,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
