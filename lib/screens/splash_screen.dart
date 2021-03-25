import 'dart:async';

import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/screens/auth/login_screen.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashDelay = 5;
  bool isFirstTime = true;
  final splashBgImage = Image.asset('${BASE_IMAGE_PATH}bottom_circles.png', fit: BoxFit.fill,);
  PackageInfo _packageInfo = PackageInfo();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(splashBgImage.image, context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: splashBgImage,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('${BASE_IMAGE_PATH}splash_overlay.png'),
                    height: 180,
                    width: 180,),
                  FutureBuilder(
                      future: _initPackageInfo(context),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          return Text(S.of(context).build +
                              ': ${_packageInfo.buildNumber} , ${S.of(context)
                              .version}: ${_packageInfo.version}',
                            style: TextStyle(
                            ),
                          );
                        }else{
                          return CircularProgressIndicator();
                        }
                      }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<PackageInfo> _initPackageInfo(BuildContext context) async {
    _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo;
  }
}
