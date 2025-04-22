import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_model/reader_settings_data.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';
import '../../repository/book_repository.dart';
import '../../repository/bookmark_repository.dart';
import '../../repository/cache_repository/cache_repository.dart';
import '../../repository/collection_repository.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_success_dialog.dart';
import '../settings_page/settings_card.dart';

part 'cards/cache_card.dart';
part 'cards/data_card.dart';
part 'cards/preference_card.dart';
part 'widgets/list_tile.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.resetPageTitle),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _PreferenceCard(),
              _CacheCard(),
              _DataCard(),
            ],
          ),
        ),
      ),
    );
  }
}
