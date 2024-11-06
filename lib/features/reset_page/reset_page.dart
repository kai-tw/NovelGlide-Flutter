import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/book_repository.dart';
import '../../repository/bookmark_repository.dart';
import '../../repository/collection_repository.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('Reset Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDeleteDialog(
                            title: 'Delete all books',
                            content: 'This will delete all books.\n'
                                'It cannot be recovered.',
                            onDelete: () => BookRepository.reset(),
                          ),
                        );
                      },
                      leading: const Icon(Icons.delete_forever_rounded),
                      title: const Text('Delete all books'),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDeleteDialog(
                            title: 'Delete all collections',
                            content: 'This will delete all collections.\n'
                                'It cannot be recovered.',
                            onDelete: () => CollectionRepository.reset(),
                          ),
                        );
                      },
                      leading: const Icon(Icons.delete_forever_rounded),
                      title: const Text('Delete all collections'),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDeleteDialog(
                            title: 'Delete all bookmarks',
                            content: 'This will delete all bookmarks.\n'
                                'It cannot be recovered.',
                            onDelete: () => BookmarkRepository.reset(),
                          ),
                        );
                      },
                      leading: const Icon(Icons.delete_forever_rounded),
                      title: const Text('Delete all bookmarks'),
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDeleteDialog(
                            title: 'Reset the preferences',
                            content: 'This will reset the preferences.\n'
                                'It cannot be recovered.',
                            deleteIcon: Icons.refresh_rounded,
                            deleteLabel: 'Reset',
                            onDelete: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                            },
                          ),
                        );
                      },
                      leading: const Icon(Icons.refresh_rounded),
                      title: const Text('Reset the preferences'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
