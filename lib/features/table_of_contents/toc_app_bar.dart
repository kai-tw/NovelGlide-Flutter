import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_back_button.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_edit_book_button.dart';

class TocAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TocAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.bookName != current.bookName,
      builder: (_, state) {
        return AppBar(
          leading: const CommonBackButton(),
          title: Text(
            state.bookName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            TocEditBookButton(bookName: state.bookName),
          ],
        );
      },
    );
  }
}

enum TOCAppBarActionType { edit, import }
