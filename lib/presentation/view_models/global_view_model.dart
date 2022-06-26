import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class GlobalViewModel with ChangeNotifier {
  //////// private variables.............
  int _bottomNavIndex = 0;
  int _currentIndex = 0;

  bool _networkConnected = false;

  bool? get networkConnected => _networkConnected;

  final Connectivity _connectivity = Connectivity();

////////// setters...................
  setBottomNavIndex(int index, {int? currentIndex}) {
    _bottomNavIndex = index;

    currentIndex != null ? _currentIndex = currentIndex : _currentIndex = 0;

    notifyListeners();
  }

  setNetworkConnected(bool value) {
    _networkConnected = value;
    notifyListeners();
  }

//////////getters.............
  int getBottomNavIndex() {
    return _bottomNavIndex;
  }

  int getCurrentNavIndex() {
    return _currentIndex;
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
      return checkNetworkConnectivity(ConnectivityResult.none);
    }

    return checkNetworkConnectivity(result);
  }

  Future<void> checkNetworkConnectivity(
      ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      setNetworkConnected(true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setNetworkConnected(true);
    } else {
      setNetworkConnected(false);
    }
  }
}
