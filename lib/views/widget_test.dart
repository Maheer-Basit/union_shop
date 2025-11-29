import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/navbar.dart';

void main() {
  group('NavBar', () {
    // verifies that hovering the mouse over the 'Home' nav text applies
    // an underline decoration.
    testWidgets('hovering Home underlines text', (tester) async {
      // Arrange: render NavBar inside a wide MediaQuery so it shows.
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(builder: (ctx) {
              return NavBar(
                currentRoute: '/',
                onNavigate: (_) {},
                onSaleTap: () {},
              );
            }),
          ),
        ),
      );

      // Pre-check: the 'Home' label exists and is not underlined initially.
      final homeFinder = find.text('Home');
      expect(homeFinder, findsOneWidget);
      final Text before = tester.widget(homeFinder);
      expect(before.style?.decoration, isNot(TextDecoration.underline));

      // Act: simulate mouse hover over the Home label.
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(homeFinder));
      await tester.pumpAndSettle();

      // Assert: after hover, the Text widget should show an underline.
      final Text after = tester.widget(homeFinder);
      expect(after.style?.decoration, TextDecoration.underline);

      await gesture.removePointer();
    });
  });
}
