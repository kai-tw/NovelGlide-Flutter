import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/popup_menu_utils.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../../../../shared_components/common_delete_dialog.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../cubit/bookshelf_cubit.dart';

class BookshelfAppBarMoreButton extends StatelessWidget {
  const BookshelfAppBarMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      clipBehavior: Clip.hardEdge,
      itemBuilder: _itemBuilder,
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
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
            appLocalizations.bookshelfSortName,
            appLocalizations.bookshelfSortLastModified,
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
