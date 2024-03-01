import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookmark_list/scaffold.dart';
import '../bookshelf/bookshelf.dart';
import 'bloc/navigation_bloc.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        switch (state.navItem) {
          case NavigationItem.bookshelf:
            return const Bookshelf();
          case NavigationItem.bookmark:
            return const BookmarkList();
          case NavigationItem.settings:
            return const Bookshelf();
        }
      },
    );
  }
}