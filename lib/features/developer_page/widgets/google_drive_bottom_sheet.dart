part of '../developer_page.dart';

class _GoogleDriveBottomSheet extends StatelessWidget {
  const _GoogleDriveBottomSheet({required this.file});

  final drive.File file;

  @override
  Widget build(BuildContext context) {
    final _GoogleDriveCubit cubit = BlocProvider.of<_GoogleDriveCubit>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      builder: (BuildContext sheetContext, ScrollController scrollController) {
        return ListView(
          controller: scrollController,
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.folder_zip_rounded),
              title: Text(file.name ?? 'Untitled File'),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                if (file.id != null) {
                  Navigator.of(sheetContext).pop();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return FutureBuilder<bool>(
                        future: cubit.deleteFile(file.id!),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return AlertDialog(
                              icon: const Icon(Icons.check_rounded,
                                  color: Colors.green, size: 60.0),
                              content: const Text('Delete Successfully'),
                              actions: <Widget>[
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    cubit.refresh();
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                  label: const Text('Close'),
                                ),
                              ],
                            );
                          } else {
                            return const AlertDialog(
                              content: SizedBox.square(
                                  dimension: 100.0, child: CommonLoading()),
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.delete_rounded),
              title: const Text('Delete this file'),
            ),
            ListTile(
              onTap: () {
                if (file.id != null) {
                  Navigator.of(sheetContext).pop();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return FutureBuilder<bool>(
                        future: cubit.copyToDrive(file.id!),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return AlertDialog(
                              icon: const Icon(Icons.check_rounded,
                                  color: Colors.green, size: 60.0),
                              content: const Text('Copy Successfully'),
                              actions: <Widget>[
                                TextButton.icon(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.close_rounded),
                                  label: const Text('Close'),
                                ),
                              ],
                            );
                          } else {
                            return const AlertDialog(
                              content: SizedBox.square(
                                  dimension: 100.0, child: CommonLoading()),
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.copy_rounded),
              title: const Text('Copy to my drive'),
            ),
          ],
        );
      },
    );
  }
}
