import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/popup_menu_utils.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../../../../shared_components/common_delete_dialog.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../bookshelf/cubit/bookshelf_cubit.dart';
import '../../bookshelf/cubit/bookshelf_state.dart';
import '../cubit/book_list_cubit.dart';

class BookListAppBarMoreButton extends StatefulWidget {
  const BookListAppBarMoreButton({super.key});

  @override
  State<BookListAppBarMoreButton> createState() =>
      _BookListAppBarMoreButtonState();
}

class _BookListAppBarMoreButtonState extends State<BookListAppBarMoreButton> {
  bool _isListDragging = false;
  bool _isTabRunning = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<BookListCubit, BookListState>(
          listenWhen: (BookListState previous, BookListState current) =>
              previous.isDragging != current.isDragging,
          listener: (BuildContext _, BookListState state) {
            setState(() {
              _isListDragging = state.isDragging;
            });
          },
        ),
        BlocListener<BookshelfCubit, BookshelfState>(
          listenWhen: (BookshelfState previous, BookshelfState current) =>
              previous.isTabRunning != current.isTabRunning,
          listener: (BuildContext _, BookshelfState state) {
            setState(() {
              _isTabRunning = state.isTabRunning;
            });
          },
        ),
      ],
      child: PopupMenuButton<void>(
        enabled: !_isListDragging && !_isTabRunning,
        clipBehavior: Clip.hardEdge,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookListCubit cubit = BlocProvider.of<BookListCubit>(context);
    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (cubit.state.code.isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      PopupMenuUtils.addSection(entries, <PopupMenuItem<void>>[
        SharedList.buildSelectionModeButton(context: context, cubit: cubit),
      ]);
    }

    // Sorting Section
    PopupMenuUtils.addSection(
        entries,
        SharedList.buildSortMenu(
          titleList: <String>[
            appLocalizations.bookName,
            appLocalizations.dateAdded,
          ],
          sortOrderList: <SortOrderCode>[
            SortOrderCode.name,
            SortOrderCode.modifiedDate,
          ],
          cubit: cubit,
        ));

    // List View Changing Section
    PopupMenuUtils.addSection(entries,
        SharedList.buildGeneralViewMenu(context: context, cubit: cubit));

    // Operation Section
    if (cubit.state.code.isLoaded &&
        cubit.state.isSelecting &&
        cubit.state.selectedSet.isNotEmpty) {
      PopupMenuUtils.addSection(entries, <PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => CollectionAddBookScaffold(
                dataSet: cubit.state.selectedSet,
              ),
            ));
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const Icon(Icons.collections_bookmark_rounded),
            title: Text(appLocalizations.addToCollection),
          ),
        ),
        PopupMenuItem<void>(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CommonDeleteDialog(
                  onAccept: () => cubit.deleteSelectedBooks(),
                );
              },
            );
          },
          child: const SharedListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
