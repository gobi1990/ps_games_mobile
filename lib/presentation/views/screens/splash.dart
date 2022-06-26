import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psgames/constants/assets.dart';
import 'package:psgames/constants/strings.dart';
import 'package:psgames/utils/device_utils.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';

import '../../../routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                // image: DecorationImage(
                //     fit: BoxFit.fill, image: AssetImage(Assets.splashBackground)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ////////////// App Icon................
                    Container(
                      padding: EdgeInsets.only(
                          bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                      child: Image.asset(
                        Assets.app_logo,
                        scale: 0.5,
                      ),
                    ),
                    //////////// App Title...............
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledWidth(context, 0.2)),
                        child: TextView(
                          text: Strings.app_name,
                          fontSize: 35,
                          maxLines: 2,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

/////////// Timer for 2000ms.................
  Timer startTimer() {
    var _duration = Duration(milliseconds: 2000);
    _timer = Timer(_duration, navigate);
    return _timer;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

//////////// Navigation to Initial screen ...................
  void navigate() async {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.initial, (route) => false);
  }
}
