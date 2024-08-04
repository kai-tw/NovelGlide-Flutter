import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:intl/intl.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
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
                        return const SliverFillRemaining(
                          child: Center(
                            child: CommonListEmpty(),
                          ),
                        );

                      case BackupManagerGoogleDriveErrorCode.normal:
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final File file = state.files![index];
                              final String? formatDate =
                                  file.createdTime != null ? DateFormat().format(file.createdTime!) : null;
                              return ListTile(
                                leading: const Icon(Icons.folder_zip_rounded),
                                title: Text(file.name ?? appLocalizations.fileSystemUntitledFile, overflow: TextOverflow.ellipsis),
                                subtitle: formatDate != null ? Text(appLocalizations.fileSystemCreateOnDate(formatDate)) : null,
                                trailing: IconButton(
                                  onPressed: () {
                                    if (file.id != null) {
                                      cubit.deleteFile(file.id!);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    semanticLabel: appLocalizations.backupManagerDeleteBackup,
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
