import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../toolbox/datetime_utility.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'developer_page_google_drive_bottom_sheet.dart';
import 'bloc/developer_page_google_drive_select_bloc.dart';

class DeveloperPageGoogleDriveFileManager extends StatelessWidget {
  const DeveloperPageGoogleDriveFileManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeveloperPageGoogleDriveSelectCubit()..init(),
      child: _BackupManagerGoogleDriveFileManager(key: key),
    );
  }
}

class _BackupManagerGoogleDriveFileManager extends StatelessWidget {
  const _BackupManagerGoogleDriveFileManager({super.key});

  @override
  Widget build(BuildContext context) {
    final DeveloperPageGoogleDriveSelectCubit cubit = BlocProvider.of<DeveloperPageGoogleDriveSelectCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text("Google Drive File Manager"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => cubit.refresh(),
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                BlocBuilder<DeveloperPageGoogleDriveSelectCubit, DeveloperPageGoogleDriveSelectState>(
                  buildWhen: (previous, current) => previous.errorCode != current.errorCode,
                  builder: (context, state) {
                    switch (state.errorCode) {
                      case BackupManagerGoogleDriveErrorCode.unInitialized:
                        return const SliverFillRemaining(
                          child: Center(
                            child: CommonLoading(),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.signInError:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Failed to sign in to Google Drive"),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.permissionDenied:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Permission denied"),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.unknownError:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Unknown error"),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.emptyFolder:
                        return const CommonSliverListEmpty();

                      case BackupManagerGoogleDriveErrorCode.normal:
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final drive.File file = state.files![index];
                              final String formatDate = DateTimeUtility.format(file.modifiedTime);
                              IconData iconData;

                              switch (file.mimeType) {
                                case 'application/vnd.google-apps.folder':
                                  iconData = Icons.folder_rounded;
                                  break;

                                case 'application/zip':
                                  iconData = Icons.folder_zip_rounded;
                                  break;

                                case 'application/epub+zip':
                                  iconData = Icons.book_rounded;
                                  break;

                                default:
                                  iconData = Icons.insert_drive_file_rounded;
                              }

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 18.0, right: 14.0),
                                  child: Icon(iconData),
                                ),
                                title: Text(
                                  file.name ?? "Untitled File",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  formatDate,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        scrollControlDisabledMaxHeightRatio: 1.0,
                                        showDragHandle: true,
                                        builder: (_) => BlocProvider.value(
                                          value: cubit,
                                          child: DeveloperPageGoogleDriveBottomSheet(file: file),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      semanticLabel: "More",
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: state.files!.length,
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
