part of '../developer_page.dart';

class _GoogleDriveFileManager extends StatelessWidget {
  const _GoogleDriveFileManager();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _GoogleDriveCubit()..init(),
      child: const _GoogleDriveFileManagerContent(),
    );
  }
}

class _GoogleDriveFileManagerContent extends StatelessWidget {
  const _GoogleDriveFileManagerContent();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_GoogleDriveCubit>(context);
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
                BlocBuilder<_GoogleDriveCubit, _GoogleDriveState>(
                  buildWhen: (previous, current) =>
                      previous.errorCode != current.errorCode,
                  builder: (context, state) {
                    switch (state.errorCode) {
                      case _GoogleDriveErrorCode.unInitialized:
                        return const SliverFillRemaining(
                          child: Center(
                            child: CommonLoading(),
                          ),
                        );

                      case _GoogleDriveErrorCode.signInError:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Failed to sign in to Google Drive"),
                          ),
                        );

                      case _GoogleDriveErrorCode.permissionDenied:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Permission denied"),
                          ),
                        );

                      case _GoogleDriveErrorCode.unknownError:
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Unknown error"),
                          ),
                        );

                      case _GoogleDriveErrorCode.emptyFolder:
                        return const CommonSliverListEmpty();

                      case _GoogleDriveErrorCode.normal:
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final drive.File file = state.files![index];
                              final String formatDate =
                                  DateTimeUtils.format(file.modifiedTime);
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
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 14.0),
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
                                        scrollControlDisabledMaxHeightRatio:
                                            1.0,
                                        showDragHandle: true,
                                        builder: (_) => BlocProvider.value(
                                          value: cubit,
                                          child: _GoogleDriveBottomSheet(
                                            file: file,
                                          ),
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