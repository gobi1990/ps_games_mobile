import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';

import 'presentation/view_models/global_view_model.dart';
import 'presentation/views/screens/splash.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalViewModel()),
          ChangeNotifierProvider(create: (_) => GamesViewModel()),
        ],
        child: MaterialApp(
          title: 'PS Games',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: Routes.routes,
        ));
  }
}
