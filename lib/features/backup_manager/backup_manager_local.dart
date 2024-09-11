import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/file_path.dart';
import 'bloc/backup_manager_local_bloc.dart';

class BackupManagerLocal extends StatelessWidget {
  const BackupManagerLocal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackupManagerLocalCubit(),
      child: const _BackupManagerLocal(),
    );
  }
}

class _BackupManagerLocal extends StatelessWidget {
  const _BackupManagerLocal({super.key});

  @override
  Widget build(BuildContext context) {
    final BackupManagerLocalCubit cubit = BlocProvider.of<BackupManagerLocalCubit>(context);

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.folder_rounded),
            title: const Text('Saved locations'),
            subtitle: Text(FilePath.instance.androidExternalStorage ?? FilePath.instance.documentFolder),
          ),
          BlocBuilder<BackupManagerLocalCubit, BackupManagerLocalState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              switch (state.code) {
                case BackupManagerLocalCode.idle:
                  return ListTile(
                    leading: const Icon(Icons.folder_zip_rounded),
                    title: Text('Create a local backup'),
                    onTap: () => cubit.createBackup(),
                  );

                case BackupManagerLocalCode.loading:
                  return const ListTile(
                    leading: Icon(Icons.folder_zip_rounded),
                    title: Text('Creating a local backup'),
                    enabled: false,
                  );

                case BackupManagerLocalCode.success:
                  return const ListTile(
                    leading: Icon(Icons.check_rounded),
                    title: Text('Local backup created'),
                    iconColor: Colors.green,
                    textColor: Colors.green,
                  );

                case BackupManagerLocalCode.error:
                  return ListTile(
                    leading: const Icon(Icons.close_rounded),
                    title: const Text('Error creating a local backup'),
                    iconColor: Theme.of(context).colorScheme.error,
                    textColor: Theme.of(context).colorScheme.error,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}