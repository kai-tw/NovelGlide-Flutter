import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:novel_glide/app/app.dart';
import 'package:novel_glide/core/setup_dependencies.dart';

final GetIt sl = GetIt.instance;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App on Android Phone', () {
    testWidgets('Screenshot', (WidgetTester tester) async {
      await setupDependencies();

      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();

      // Take the screenshot of the homepage.
      await binding.takeScreenshot('homepage');

      // Verify that the homepage is displayed.
      expect(find.byKey(const ValueKey<String>('homepage')), findsOneWidget);
    });
  });
}
