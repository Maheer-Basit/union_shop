import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/hero_section.dart';

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
            child: Scaffold(
              body: Builder(builder: (ctx) {
                return NavBar(
                  currentRoute: '/other',
                  onNavigate: (_) {},
                  onSaleTap: () {},
                );
              }),
            ),
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
    testWidgets('Clicking Shop dropdown', (tester) async {
      // Arrange: render NavBar inside a wide MediaQuery so it shows.
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Scaffold(
              body: Builder(builder: (ctx) {
                return NavBar(
                  currentRoute: '/product',
                  onNavigate: (_) {},
                  onSaleTap: () {},
                );
              }),
            ),
          ),
        ),
      );

      // Pre-check: the 'Shop' label exists.
      final shopFinder = find.text('Shop');
      expect(shopFinder, findsOneWidget);

      // Act: simulate tap on the Shop label.
      await tester.tap(shopFinder);
      await tester.pumpAndSettle();

      // Assert: after tap, the dropdown menu should be visible.
      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
    });
    group('Footer', () {
      testWidgets('Contains Opening Hours section', (tester) async {
        // Arrange: render Footer inside a MaterialApp.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (ctx) {
                return Footer();
              }),
            ),
          ),
        );

        // Assert: verify that the Opening Hours section is present.
        expect(find.text('Opening Hours'), findsOneWidget);
        expect(find.text('Mon - Fri: 9:00 - 17:00'), findsOneWidget);
        expect(find.text('Saturday: 10:00 - 16:00'), findsOneWidget);
        expect(find.text('Sunday: Closed'), findsOneWidget);
      });
    });
    group('Hero Section', () {
      testWidgets('Contains correct title/subtitle in the initial slide',
          (tester) async {
        // Arrange: render HeroSection inside a MaterialApp.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (ctx) {
                return const HeroSection();
              }),
            ),
          ),        
          );
        // Assert: verify that the initial slide's title and subtitle are present.
        expect(find.text('Essential range'), findsOneWidget);
        expect(find.text('Explore our essential collection'), findsOneWidget);
      });

    });
  });
}
