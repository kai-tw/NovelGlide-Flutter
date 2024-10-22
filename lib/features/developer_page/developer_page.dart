import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../toolbox/file_path.dart';
import '../../toolbox/route_helper.dart';
import '../common_components/common_back_button.dart';
import 'developer_page_google_drive_file_manager.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('Developer Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Device'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            title: const Text('devicePixelRatio'),
            subtitle: Text("${MediaQuery.of(context).devicePixelRatio}"),
          ),
          ListTile(
            title: const Text('size.width'),
            subtitle: Text("${MediaQuery.of(context).size.width}"),
          ),
          ListTile(
            title: const Text('size.height'),
            subtitle: Text("${MediaQuery.of(context).size.height}"),
          ),
          ListTile(
            title: const Text('Orientation'),
            subtitle: Text("${MediaQuery.of(context).orientation}"),
          ),
          ListTile(
            title: const Text('Platform brightness'),
            subtitle: Text("${MediaQuery.of(context).platformBrightness}"),
          ),
          const Divider(),
          ListTile(
            title: const Text('File Paths'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            title: const Text('libraryRoot'),
            subtitle: Text(FilePath.libraryRoot),
          ),
          ListTile(
            title: const Text('dataRoot'),
            subtitle: Text(FilePath.dataRoot),
          ),
          const Divider(),
          ListTile(
            title: const Text('Firebase'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            onTap: () => FirebaseCrashlytics.instance.crash(),
            leading: const Icon(Icons.error_outline_rounded),
            title: const Text('Force crash'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Google Drive'),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(RouteHelper.pushRoute(
                const DeveloperPageGoogleDriveFileManager())),
            leading: const Icon(Icons.folder),
            title: const Text('File Browser'),
          ),
        ],
      ),
    );
  }
}
