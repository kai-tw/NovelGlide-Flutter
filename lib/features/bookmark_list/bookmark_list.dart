import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_scaffold.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookmarkListCubit(),
      child: const BookmarkListScaffold(),
    );
  }
}
