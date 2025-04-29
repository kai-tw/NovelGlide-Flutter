import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';
import '../book/data/repository/book_repository.dart';
import '../bookmark/data/bookmark_repository.dart';
import '../collection/data/collection_repository.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_success_dialog.dart';
import '../reader/data/model/reader_settings_data.dart';
import '../reader/data/repository/cache_repository.dart';
import '../settings_page/settings_card.dart';

part 'widgets/cache_card.dart';
part 'widgets/data_card.dart';
part 'widgets/list_tile.dart';
part 'widgets/preference_card.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.resetPageTitle),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
