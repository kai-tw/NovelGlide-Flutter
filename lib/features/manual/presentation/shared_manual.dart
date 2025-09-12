import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../locale_system/domain/entities/app_locale.dart';
import '../../locale_system/locale_utils.dart';
import 'cubit/shared_manual_cubit.dart';
import 'cubit/shared_manual_file_path.dart';
import 'widgets/shared_manual_content.dart';

class SharedManual extends StatelessWidget {
  const SharedManual({
    super.key,
    required this.title,
    required this.filePath,
  });

  final String title;
  final SharedManualFilePath filePath;

  @override
  Widget build(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    final AppLocale appLocale = LocaleUtils.convertLocaleToAppLocale(locale);
    return BlocProvider<SharedManualCubit>(
      create: (_) => sl<SharedManualCubit>()
        ..loadManual(SharedManualFilePath.explore, appLocale),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 16.0,
            ),
            child: SharedManualContent(),
          ),
        ),
      ),
    );
  }
}
