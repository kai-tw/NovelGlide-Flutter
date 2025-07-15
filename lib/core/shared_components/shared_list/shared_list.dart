import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/emoticon_collection.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../generated/i18n/app_localizations.dart';

part 'button/shared_list_delete_button.dart';
part 'button/shared_list_done_button.dart';
part 'button/shared_list_select_all_button.dart';
part 'button/shared_list_select_mode_button.dart';
part 'button/shared_list_select_mode_tile.dart';
part 'button/shared_list_sort_tile.dart';
part 'cubit/shared_list_cubit.dart';
part 'cubit/shared_list_state.dart';
part 'cubit/shared_list_type.dart';
part 'widgets/shared_list_empty.dart';
part 'widgets/shared_list_sliver_empty.dart';
part 'widgets/shared_list_tile.dart';

class SharedList extends StatelessWidget {
  const SharedList({
    super.key,
    required this.listType,
    required this.gridDelegate,
    required this.delegate,
  });

  final SharedListType listType;
  final SliverGridDelegate gridDelegate;
  final SliverChildDelegate delegate;

  @override
  Widget build(BuildContext context) {
    switch (listType) {
      case SharedListType.list:
        return SliverList(
          delegate: delegate,
        );

      case SharedListType.grid:
        return SliverGrid(
          gridDelegate: gridDelegate,
          delegate: delegate,
        );
    }
  }

  /// **************************************************************************
  /// Static methods

  /// Build the sort menu
  static List<PopupMenuItem<void>> buildSortMenu({
    required List<String> titleList,
    required List<SortOrderCode> sortOrderList,
    required SharedListCubit<dynamic> cubit,
  }) {
    return List<PopupMenuItem<void>>.generate(sortOrderList.length, (int i) {
      final SortOrderCode sortOrderCode = sortOrderList[i];
      return PopupMenuItem<void>(
        onTap: () {
          if (cubit.state.sortOrder == sortOrderCode) {
            cubit.setListOrder(isAscending: !cubit.state.isAscending);
          } else {
            cubit.setListOrder(sortOrder: sortOrderCode);
          }
        },
        child: SharedListSortButton(
          isSelected: cubit.state.sortOrder == sortOrderCode,
          isAscending: cubit.state.isAscending,
          title: titleList[i],
        ),
      );
    });
  }
}
