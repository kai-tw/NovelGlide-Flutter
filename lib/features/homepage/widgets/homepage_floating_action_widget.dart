import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/window_size.dart';
import '../../bookmark/domain/entities/bookmark_data.dart';
import '../../bookmark/presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
import '../../books/presentation/bookshelf/bookshelf_delete_drag_target.dart';
import '../../shared_components/shared_list/presentation/widgets/shared_list_delete_drag_target.dart';
import '../cubit/homepage_cubit.dart';
import 'homepage_floating_action_button.dart';

class HomepageFloatingActionWidget extends StatelessWidget {
  const HomepageFloatingActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowSize windowClass = WindowSize.of(context);
    double maxWidth =
        MediaQuery.sizeOf(context).width - kFloatingActionButtonMargin;

    if (windowClass != WindowSize.compact) {
      maxWidth *= 0.618;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Delete Drag Targets
          Expanded(
            child: BlocBuilder<HomepageCubit, HomepageState>(
              buildWhen: (HomepageState previous, HomepageState current) =>
                  previous.navItem != current.navItem,
              builder: (BuildContext context, HomepageState state) {
                switch (state.navItem) {
                  case HomepageNavigationItem.bookshelf:
                    return const Padding(
                      padding: EdgeInsets.only(
                        left: kFloatingActionButtonMargin,
                        right: kFloatingActionButtonMargin,
                      ),
                      child: BookshelfDeleteDragTarget(),
                    );

                  case HomepageNavigationItem.bookmark:
                    return const Padding(
                      padding: EdgeInsets.only(
                        left: kFloatingActionButtonMargin,
                      ),
                      child: SharedListDeleteDragTarget<BookmarkListCubit,
                          BookmarkData>(),
                    );

                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),

          // Floating Action Button
          const HomepageFloatingActionButton(),
        ],
      ),
    );
  }
}
