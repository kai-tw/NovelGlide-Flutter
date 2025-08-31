import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../../shared_components/shared_bottom_container.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/download_manager_cubit.dart';
import 'cubit/download_manager_state.dart';

class DownloadManagerScaffold extends StatelessWidget {
  const DownloadManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final DownloadManagerCubit cubit =
        BlocProvider.of<DownloadManagerCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Manager'),
      ),
      body: SafeArea(
        child: BlocBuilder<DownloadManagerCubit, DownloadManagerState>(
          builder: (BuildContext context, DownloadManagerState state) {
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
                          return Text(state.identifierList[index]);
                        },
                        itemCount: state.identifierList.length,
                      ),
                    ),
                  );
                }
            }
          },
        ),
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
          ],
        ),
      ),
    );
  }
}
