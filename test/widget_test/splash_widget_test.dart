import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:psgames/constants/strings.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';
import 'package:psgames/presentation/views/screens/splash.dart';

void main() {
  Widget _testMaterialApp({Widget? child}) {
    return MaterialApp(home: child);
  }

  group('Splash Screen - Splash screen timer test', () {
    testWidgets('Splash screen timer test', (WidgetTester tester) async {
      SplashScreen splash = SplashScreen();

      //await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.pumpWidget(
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => GlobalViewModel()),
          ChangeNotifierProvider(create: (_) => GamesViewModel()),
        ], child: _testMaterialApp(child: splash)),
      );

      /////////// App logo ...........
      expect(find.byType(Image), findsOneWidget);
      ///////// App name text ............
      expect(find.text(Strings.app_name), findsOneWidget);
    });
  });
}
