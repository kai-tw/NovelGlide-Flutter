import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_add_chapter_button.dart';
import 'widgets/toc_sliver_book_name.dart';
import 'widgets/toc_sliver_cover_banner.dart';
import 'toc_app_bar.dart';
import 'widgets/toc_sliver_list.dart';

class TOCScaffold extends StatelessWidget {
  const TOCScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(cubit.state.isDirty);
      },
      child: Scaffold(
        appBar: const TOCAppBar(),
        body: RefreshIndicator(
          onRefresh: () async => cubit.refresh(),
          child: const SlidableAutoCloseBehavior(
            child: CustomScrollView(
              slivers: [
                TOCSliverCoverBanner(),
                TOCSliverBookName(),
                TOCSliverList(),
              ],
            ),
          ),
        ),
        floatingActionButton: const TOCAddChapterButton(),
        bottomNavigationBar: Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ),
    );
  }
}
