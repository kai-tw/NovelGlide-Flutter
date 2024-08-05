import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/book_manager_bloc.dart';
import 'widgets/book_manager_floating_action_button.dart';
import 'widgets/book_manager_sliver_list.dart';
import 'widgets/book_manager_top_bar.dart';

class BookManagerScaffold extends StatelessWidget {
  const BookManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookManagerCubit()..refresh(),
      child: const _BookManagerScaffold(),
    );
  }
}

class _BookManagerScaffold extends StatelessWidget {
  const _BookManagerScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(AppLocalizations.of(context)!.bookManagerTitle),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => BlocProvider.of<BookManagerCubit>(context).refresh(),
          child: const Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BookManagerTopBar(),
                ),
                BookManagerSliverList(),
                SliverPadding(padding: EdgeInsets.only(bottom: 86.0)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const BookManagerFloatingActionButton(),
    );
  }
}