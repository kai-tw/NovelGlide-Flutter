import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import '../bookmark_list/widgets/bookmark_list_operation_panel.dart';
import '../bookshelf/widgets/bookshelf_operation_panel.dart';
import '../collection_list/collection_list_operation_panel.dart';
import 'bloc/homepage_bloc.dart';
import 'homepage_floating_action_button.dart';

class HomepageTabSection extends StatelessWidget {
  const HomepageTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    double maxWidth = MediaQuery.of(context).size.width - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kFloatingActionButtonMargin),
              child: BlocBuilder<HomepageCubit, HomepageState>(
                buildWhen: (previous, current) => previous.navItem != current.navItem,
                builder: (context, state) {
                  switch (state.navItem) {
                    case HomepageNavigationItem.bookshelf:
                      return const BookshelfOperationPanel();

                    case HomepageNavigationItem.collection:
                      return const CollectionListOperationPanel();

                    case HomepageNavigationItem.bookmark:
                      return const BookmarkListOperationPanel();

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          const HomepageFloatingActionButton(),
        ],
      ),
    );
  }
}
