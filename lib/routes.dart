import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psgames/presentation/views/screens/favorites.dart';
import 'package:psgames/presentation/views/screens/game_detail.dart';
import 'package:psgames/presentation/views/screens/more.dart';
import 'package:psgames/presentation/views/screens/search.dart';

import 'presentation/views/screens/home.dart';
import 'presentation/views/screens/initial_screen.dart';

class Routes {
  Routes._();

  static const String home = '/presentation/views/screens/home';
  static const String more = '/presentation/views/screens/more';
  static const String favorites = '/presentation/views/screens/favourites';
  static const String search = '/presentation/views/screens/search';
  static const String Splash = '/presentation/views/screens/splash';
  static const String initial = '/presentation/views/screens/initial_screen';
  static const String details = '/presentation/views/screens/game_detail';

//////////// Navigation screens with botoom nav bar.............
  static final List<Widget> bottommNavigationScreens = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
    MoreScreen(),
    GameDetailsScreen()
  ];

  static final routes = <String, WidgetBuilder>{
    initial: (BuildContext context) => InitialScreen(),
    details: (BuildContext context) => GameDetailsScreen(),
    search: (BuildContext context) => SearchScreen(),
    favorites: (BuildContext context) => FavouriteScreen(),
    more: (BuildContext context) => MoreScreen(),
  };

///////////// Screen route generator ..................
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case details:
        return MaterialPageRoute(builder: (_) => GameDetailsScreen());
      case search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => FavouriteScreen());
      case more:
        return MaterialPageRoute(builder: (_) => MoreScreen());
      default:
        return errorRoute();
    }
  }

/////////////// Error on wrong route.................
  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error!'),
        ),
      );
    });
  }
}
