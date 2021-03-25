import 'dart:io';

import 'package:be_healthy_delivery_app/screens/auth/login_screen.dart';
import 'package:be_healthy_delivery_app/screens/auth/sign_up_screen.dart';
import 'package:be_healthy_delivery_app/screens/dashboard_screen.dart';
import 'package:be_healthy_delivery_app/screens/splash_screen.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:be_healthy_delivery_app/utils/route_names.dart';
import 'package:be_healthy_delivery_app/utils/view_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _getSelectedLanguage();
    super.initState();
    // remoteMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Be Healthy Delivery App',

      initialRoute: SPLASH_SCREEN,
      // initialRoute: SPLASH_SCREEN,

      routes: {
        SPLASH_SCREEN: (context) => SplashScreen(),
        LOG_IN_SCREEN: (context) => LoginScreen(),
        SIGN_UP_SCREEN: (context) => SignUpScreen(),
        DASHBOARD_SCREEN: (context) => DashboardScreen()
      },

      theme: ThemeData(
        primaryColor: kOrangeMaterialColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          // color: kOrangeMaterialColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Colors.white)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,),
      home: SplashScreen(),

      //Localization
      localizationsDelegates: [
        // 1
        S.delegate,
        // 2
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar'),
        const Locale('en', 'US')
      ],
    );
  }

  _getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    var selectedLanguage = prefs.getString(SELECTED_LANGUAGE ?? 'ar');
    if(selectedLanguage == null){
      selectedLanguage = 'ar';
      prefs.setString(SELECTED_LANGUAGE, 'ar');
    }
    S.load(Locale(selectedLanguage));
  }


  void remoteMessages() async{
    FirebaseMessaging fcm = FirebaseMessaging.instance;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


    String token = await fcm.getToken();
    print(token);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);




    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.

      if (notification != null && android != null) {
        ViewUtils.showSuccessToast(notification.body);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                'This channel is used for important notifications.',
                icon: android?.smallIcon,
                importance: Importance.max,
                priority: Priority.high,
                ongoing: true,
                // other properties...
              ),
            ));
      }

    });


    if(Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }

  }

}

