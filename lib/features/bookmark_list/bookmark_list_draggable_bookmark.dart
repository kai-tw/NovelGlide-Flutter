import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import 'bloc/bookmark_list_bloc.dart';
import '../common_components/bookmark_widget.dart';

class BookmarkListDraggableBookmark extends StatelessWidget {
  final BookmarkData _data;

  const BookmarkListDraggableBookmark(this._data, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return LongPressDraggable(
        onDragStarted: () => cubit.setDragging(true),
        onDragEnd: (_) => cubit.setDragging(false),
        onDragCompleted: () {
          _data.delete();
          cubit.refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: _data,
        feedback: Opacity(
          opacity: 0.7,
          child: Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                  blurRadius: 8.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: BookmarkWidget(_data),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: SizedBox(
            width: constraints.maxWidth,
            child: BookmarkWidget(_data),
          ),
        ),
        child: Container(
          width: constraints.maxWidth,
          color: Colors.transparent,
          child: BookmarkWidget(_data),
        ),
      );
    });
  }
}
