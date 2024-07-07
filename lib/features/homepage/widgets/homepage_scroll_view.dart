import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/window_class.dart';
import '../bloc/navigation_bloc.dart';

class HomepageScrollView extends StatelessWidget {
  const HomepageScrollView({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    List<Widget> sliverList = List.from(slivers);

    return BlocBuilder<NavigationCubit, NavigationState>(builder: (BuildContext context, NavigationState state) {
      /// Prevent the content from being covered by the floating action button.
      /// Prevent the content from being covered by the navigation bar.
      double paddingBottom = (state.navItem == NavigationItem.bookshelf ? 48.0 : 0.0) +
          (windowClass == WindowClass.compact ? kBottomNavigationBarHeight : 0.0);

      sliverList.add(SliverPadding(padding: EdgeInsets.only(bottom: paddingBottom)));

      return Scrollbar(
        child: CustomScrollView(
          slivers: sliverList,
        ),
      );
    });
  }
}
