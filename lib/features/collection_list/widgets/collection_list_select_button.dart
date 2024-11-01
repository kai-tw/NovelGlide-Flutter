import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_select_mode_text_button.dart';
import '../bloc/collection_list_bloc.dart';

class CollectionListSelectButton extends StatelessWidget {
  const CollectionListSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.collectionList != current.collectionList ||
          previous.selectedCollections != current.selectedCollections,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = CommonSelectModeTextButton(
            isEmpty: state.collectionList.isEmpty,
            isSelectAll:
                state.selectedCollections.length == state.collectionList.length,
            selectAll: cubit.selectAll,
            deselectAll: cubit.deselectAll,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
      },
    );
  }
}
