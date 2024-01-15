import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookshelf/bookshelf.dart';
import 'bloc/navigation_bloc.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return const Bookshelf();
        // switch (state.navItem) {
        //   case NavigationItem.bookshelf:
        //     break;
        //   case NavigationItem.bookmark:
        //     break;
        //   case NavigationItem.settings:
        //     break;
        // }
      },
    );
  }
}