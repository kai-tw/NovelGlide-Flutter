import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bookmark_list_bloc.dart';

class BookmarkListAppBarPopupMenuButton extends StatelessWidget {
  const BookmarkListAppBarPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
        List<PopupMenuEntry<dynamic>> entries = [];

        /// Edit mode
        switch (cubit.state.code) {
          case BookmarkListStateCode.normal:
            if (!cubit.state.isSelecting) {
              entries.add(PopupMenuItem(
                onTap: () => cubit.setSelecting(true),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text("Edit"),
                    ),
                    Icon(Icons.edit_rounded),
                  ],
                ),
              ));
            }
            break;
          default:
        }

        return entries;
      },
    );
  }
}