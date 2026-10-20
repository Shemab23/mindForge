import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mindforge/main.dart';
import 'package:mindforge/core/state/app_state.dart';

void main() {
  testWidgets('App initialization and splash screen smoke test', (
    WidgetTester tester,
  ) async {
    // 1. Build our structured app frame wrapper inside the tester ecosystem
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MindForgeApp(),
      ),
    );

    // 2. Verify that the system successfully boots up and displays the Splash layout header text
    expect(find.text('MINDFORGE'), findsOneWidget);
    expect(find.text('Initializing Environment (30s)...'), findsOneWidget);

    // 3. Verify that the functional skip toggle button component frame target is rendered safely
    expect(find.text('Skip Demo Timer ⚡'), findsOneWidget);
  });
}
