import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/shared_bottom_container.dart';
import 'widgets/explore_add_favorite_page_action_bar.dart';
import 'widgets/explore_add_favorite_page_form.dart';

class ExploreAddFavoritePageScaffold extends StatelessWidget {
  const ExploreAddFavoritePageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.discoverAddToFavorites),
      ),
      body: const SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: ExploreAddFavoritePageForm(),
          ),
        ),
      ),
      bottomNavigationBar: const SharedBottomContainer(
        child: ExploreAddFavoritePageActionBar(),
      ),
    );
  }
}
