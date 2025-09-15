import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:novel_glide/app/app.dart';
import 'package:novel_glide/core/file_system/domain/repositories/temp_repository.dart';
import 'package:novel_glide/core/setup_dependencies.dart';
import 'package:novel_glide/features/books/domain/use_cases/book_add_use_case.dart';
import 'package:novel_glide/firebase_options.dart';
import 'package:novel_glide/generated/i18n/app_localizations.dart';

final GetIt sl = GetIt.instance;

void main() async {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  bool canSetup = true;

  group('App on Android Phone', () {
    for (final Locale locale in AppLocalizations.supportedLocales) {
      final String screenshotString = _localeToImgFileName(locale);
      final String bookLocaleString = _localeToBookName(locale);

      _progress(binding, canSetup, locale, bookLocaleString, (int index) {
        if (Platform.isAndroid) {
          // Android Phone folder name
          // const String deviceFolder = 'phoneScreenshots';

          // Android Tablet 7 inches folder name
          // const String deviceFolder = 'sevenInchScreenshots';

          // Android Tablet 10 inches folder name
          const String deviceFolder = 'tenInchScreenshots';

          final String directoryRoot =
              'android/fastlane/metadata/android/$screenshotString/images/$deviceFolder/';

          return '$directoryRoot/${index + 1}_$screenshotString.png';
        } else {
          // iOS
          final String directoryRoot =
              'ios/fastlane/screenshots/$screenshotString/';
          // iPhone
          // final String deviceFileName = '${index}_APP_IPHONE_69_$index.png';
          // iPad
          final String deviceFileName =
              '${index}_APP_IPAD_PRO_3GEN_13_$index.png';

          return directoryRoot + deviceFileName;
        }
      });

      canSetup = false;
    }
  });
}

void _progress(
  IntegrationTestWidgetsFlutterBinding binding,
  bool canSetup,
  Locale locale,
  String localeString,
  String Function(int index) getScreenshotName,
) {
  int index = 0;

  testWidgets(
    'Take screenshot for $localeString',
    (WidgetTester tester) async {
      if (canSetup) {
        await setupDependencies();

        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);

        await _importBook(
            AppLocalizations.supportedLocales.map(_localeToBookName).toList());
        await tester.pumpAndSettle();
      }

      await tester.pumpWidget(App(
        locale: locale,
        enableAccessibilityTools: false,
      ));
      await tester.pumpAndSettle();

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();

      // Take the screenshot of the homepage.
      await binding.takeScreenshot(getScreenshotName(index++));

      // Find the book
      await tester
          .tap(find.byKey(ValueKey<String>('bookList_$localeString.epub')));
      await tester.pumpAndSettle();

      // Wait 5 seconds to load the next page
      await Future<void>.delayed(const Duration(seconds: 2));

      // Take the screenshot of the Table of Contents.
      await binding.takeScreenshot(getScreenshotName(index++));

      // Click the second chapter item
      await tester.tap(find.byKey(const ValueKey<String>('tocList_1')));
      await tester.pumpAndSettle();

      // Wait 5 seconds to load the next page
      await Future<void>.delayed(const Duration(seconds: 2));

      // Take the screenshot of the Reader.
      await binding.takeScreenshot(getScreenshotName(index++));

      // Go to the next page
      await tester
          .tap(find.byKey(const ValueKey<String>('reader_next_button')));
      await tester.pumpAndSettle();

      // Wait 5 seconds to load the next page
      await Future<void>.delayed(const Duration(seconds: 2));

      // Take the screenshot of the Reader.
      await binding.takeScreenshot(getScreenshotName(index++));

      // Tap back button.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Tap back button again.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Go to explore page
      await tester.tap(find.byKey(const ValueKey<String>('homepage_explore')));
      await tester.pumpAndSettle();

      // Take the screenshot of the Reader.
      await binding.takeScreenshot(getScreenshotName(index++));

      // Verify that the homepage is displayed.
      expect(find.byKey(const ValueKey<String>('homepage')), findsOneWidget);
    },
  );
}

String _localeToBookName(Locale locale) {
  return switch (locale) {
    const Locale('en') => 'en-US',
    const Locale('zh') => 'zh-TW',
    const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hans',
      countryCode: 'CN',
    ) =>
      'zh-CN',
    const Locale('ja') => 'ja-JP',
    _ => throw UnimplementedError('Missing directory name for $locale'),
  };
}

String _localeToImgFileName(Locale locale) {
  if (Platform.isAndroid) {
    return switch (locale) {
      const Locale('en') => 'en-US',
      const Locale('zh') => 'zh-TW',
      const Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
        countryCode: 'CN',
      ) =>
        'zh-CN',
      const Locale('ja') => 'ja-JP',
      _ => throw UnimplementedError('Missing directory name for $locale'),
    };
  } else {
    return switch (locale) {
      const Locale('en') => 'en-US',
      const Locale('zh') => 'zh-Hant',
      const Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
        countryCode: 'CN',
      ) =>
        'zh-Hans',
      const Locale('ja') => 'ja',
      _ => throw UnimplementedError('Missing directory name for $locale'),
    };
  }
}

Future<void> _importBook(List<String> locales) async {
  // Import books
  final TempRepository tempRepository = sl<TempRepository>();
  final String directory = await tempRepository.getDirectoryPath();

  final Set<String> files = <String>{};
  for (final String locale in locales) {
    final ByteData data = await rootBundle.load('assets/samples/$locale.epub');
    File('$directory/$locale.epub')
      ..createSync(recursive: true)
      ..writeAsBytesSync(data.buffer.asInt8List());
    files.add('$directory/$locale.epub');
  }

  final BookAddUseCase addUseCase = sl<BookAddUseCase>();
  await addUseCase(files);

  Directory(directory).deleteSync(recursive: true);
}
