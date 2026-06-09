// Basic smoke test for the Utopia Monster Hub app.

import 'package:flutter_test/flutter_test.dart';

import 'package:utopia_monster_hub/main.dart';

void main() {
  testWidgets('App launches and shows Monster Library title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UtopiaMonsterHubApp());

    // Verify that the app title is displayed.
    expect(find.text('Monster Library'), findsOneWidget);
  });
}
