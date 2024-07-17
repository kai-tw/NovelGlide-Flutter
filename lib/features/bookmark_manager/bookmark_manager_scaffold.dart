import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/bookmark_manager_bloc.dart';
import 'widgets/bookmark_manager_floating_action_button.dart';
import 'widgets/bookmark_manager_sliver_list.dart';

class BookmarkManagerScaffold extends StatelessWidget {
  const BookmarkManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BookmarkManagerCubit()..refresh(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleBookmarkManager),
        ),
        body: const Scrollbar(
          child: CustomScrollView(
            slivers: [
              BookmarkManagerSliverList(),
              SliverPadding(padding: EdgeInsets.only(bottom: 86.0)),
            ],
          ),
        ),
        floatingActionButton: const BookmarkManagerFloatingActionButton(),
      ),
    );
  }
}
