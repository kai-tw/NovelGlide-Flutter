import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/toc_bloc.dart';

class TocScrollView extends StatelessWidget {
  final List<Widget> slivers;

  const TocScrollView({super.key, required this.slivers});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);

    /// Add the floating action button to the end of the list.
    List<Widget> sliverList = List.from(slivers);

    /// Prevent the content from being covered by the floating action button.
    sliverList.add(const SliverPadding(padding: EdgeInsets.only(bottom: 80.0)));

    return PageStorage(
      bucket: cubit.bucket,
      child: Scrollbar(
        controller: cubit.scrollController,
        child: CustomScrollView(
          key: const PageStorageKey<String>('toc-scroll-view'),
          controller: cubit.scrollController,
          slivers: sliverList,
        ),
      ),
    );
  }
}