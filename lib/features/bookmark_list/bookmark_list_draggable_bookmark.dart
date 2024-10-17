import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import '../common_components/draggable_feedback_widget.dart';
import '../common_components/draggable_placeholder_widget.dart';
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
        onDragStarted: () => cubit.isDragging = true,
        onDragEnd: (_) => cubit.isDragging = false,
        onDragCompleted: () async {
          final messenger = ScaffoldMessenger.of(context);

          await _data.delete();
          cubit.refresh();

          messenger.showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: _data,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          child: BookmarkWidget(_data),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: BookmarkWidget(_data),
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
