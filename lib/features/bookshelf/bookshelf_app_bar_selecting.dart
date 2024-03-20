import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_delete_confirm_dialog.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfAppBarSelecting extends StatelessWidget {
  const BookshelfAppBarSelecting({super.key});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelectedAll = state.selectedSet.length == state.bookList.length;
        return AppBar(
          leading: IconButton(
            onPressed: () => _onPressedLeadingButton(cubit, isSelectedAll),
            icon: Icon(isSelectedAll ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded),
          ),
          title: Text(state.selectedSet.length.toString()),
          actions: [
            IconButton(
              onPressed: () => _onPressedDeleteButton(context),
              icon: const Icon(Icons.delete_outline_rounded),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: false,
        );
      },
    );
  }

  void _onPressedLeadingButton(BookshelfCubit cubit, bool isSelectingAll) {
    if (isSelectingAll) {
      cubit.clearSelect();
    } else {
      cubit.allSelect();
    }
  }

  void _onPressedDeleteButton(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    showDialog(context: context, builder: (_) => const CommonDeleteConfirmDialog()).then((isDelete) {
      if (isDelete) {
        cubit.deleteSelect();
      } else {
        cubit.clearSelect();
      }
    });
  }
}
