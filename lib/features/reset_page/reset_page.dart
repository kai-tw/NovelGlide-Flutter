import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_model/preference_keys.dart';
import '../../data_model/theme_data_record.dart';
import '../../repository/book_repository.dart';
import '../../repository/bookmark_repository.dart';
import '../../repository/collection_repository.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';

part 'cards/delete_card.dart';
part 'cards/reset_card.dart';
part 'widgets/reset_tile.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.resetPageTitle),
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _DeleteCard(),
                _ResetCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
