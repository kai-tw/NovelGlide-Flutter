import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/popup_menu_utils.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../books/presentation/bookshelf/cubit/bookshelf_cubit.dart';
import '../../../../books/presentation/bookshelf/cubit/bookshelf_state.dart';
import '../../../../shared_components/common_delete_dialog.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../cubit/collection_list_cubit.dart';

class CollectionListAppBarMoreButton extends StatefulWidget {
  const CollectionListAppBarMoreButton({super.key});

  @override
  State<CollectionListAppBarMoreButton> createState() =>
      _CollectionListAppBarMoreButtonState();
}

class _CollectionListAppBarMoreButtonState
    extends State<CollectionListAppBarMoreButton> {
  bool _isListDragging = false;
  bool _isTabRunning = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<CollectionListCubit, CollectionListState>(
          listenWhen:
              (CollectionListState previous, CollectionListState current) =>
                  previous.isDragging != current.isDragging,
          listener: (BuildContext _, CollectionListState state) {
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
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);

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
          appLocalizations.generalName,
        ],
        sortOrderList: <SortOrderCode>[
          SortOrderCode.name,
        ],
        cubit: cubit,
      ),
    );

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
            showDialog(
              context: context,
              builder: (_) {
                return CommonDeleteDialog(
                  onAccept: () => cubit.deleteSelectedCollections(),
                );
              },
            );
          },
          enabled: cubit.state.selectedSet.isNotEmpty,
          child: const SharedListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }
}
