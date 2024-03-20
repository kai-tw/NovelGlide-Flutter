import 'package:flutter/material.dart';

import 'bookmark_list_app_bar.dart';
import 'bookmark_list_sliver_list.dart';

class BookmarkListScaffold extends StatelessWidget {
  const BookmarkListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BookmarkListAppBar(),
      body: CustomScrollView(
        slivers: [
          BookmarkListSliverList(),
        ],
      ),
    );
  }

}