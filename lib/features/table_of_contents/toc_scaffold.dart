import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../add_chapter/add_chapter_scaffold.dart';
import '../common_components/common_add_floating_action_button.dart';
import 'bloc/toc_bloc.dart';
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
      child: ThemeSwitchingArea(
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
          floatingActionButton: CommonAddFloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddChapterScaffold(bookName: cubit.bookData.name)))
                  .then((isSuccess) => _onPopBack(context, isSuccess));
            },
          ),
        ),
      ),
    );
  }

  void _onPopBack(BuildContext context, bool? isSuccess) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (isSuccess == true) {
      cubit.refresh();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addWhatSuccessfully(appLocalizations.chapter)),
      ));
    } else if (isSuccess == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(appLocalizations.addWhatFailed(appLocalizations.chapter)),
      ));
    }
  }
}
