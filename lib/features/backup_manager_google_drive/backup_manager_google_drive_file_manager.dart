import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:intl/intl.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'backup_manager_google_drive_bottom_sheet.dart';
import 'bloc/backup_manager_google_drive_select_bloc.dart';

class BackupManagerGoogleDriveFileManager extends StatelessWidget {
  const BackupManagerGoogleDriveFileManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackupManagerGoogleDriveSelectCubit()..init(),
      child: _BackupManagerGoogleDriveFileManager(key: key),
    );
  }
}

class _BackupManagerGoogleDriveFileManager extends StatelessWidget {
  const _BackupManagerGoogleDriveFileManager({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupManagerGoogleDriveSelectCubit cubit = BlocProvider.of<BackupManagerGoogleDriveSelectCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.backupManagerFileManagement),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => cubit.refresh(),
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                BlocBuilder<BackupManagerGoogleDriveSelectCubit, BackupManagerGoogleDriveSelectState>(
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
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(appLocalizations.backupManagerGoogleDriveSignInFailed),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.permissionDenied:
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(appLocalizations.fileSystemPermissionDenied),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.unknownError:
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(appLocalizations.exceptionUnknownError),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.emptyFolder:
                        return const CommonSliverListEmpty();

                      case BackupManagerGoogleDriveErrorCode.normal:
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final drive.File file = state.files![index];
                              final String? formatDate =
                                  file.createdTime != null ? DateFormat().format(file.createdTime!) : null;
                              IconData iconData;

                              switch (file.mimeType) {
                                case 'application/vnd.google-apps.folder':
                                  iconData = Icons.folder_rounded;
                                  break;

                                case 'application/zip':
                                  iconData = Icons.folder_zip_rounded;
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
                                  file.name ?? appLocalizations.fileSystemUntitledFile,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  appLocalizations.fileSystemCreateOnDate(formatDate!),
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
                                          child: BackupManagerGoogleDriveBottomSheet(file: file),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      semanticLabel: appLocalizations.backupManagerAccessibilityMore,
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
