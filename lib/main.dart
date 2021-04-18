//import 'package:bitmap/bitmap.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mydrive/Helper/dark_theme_styles.dart';
import 'package:mydrive/LoginAndRegister/LoginScreen.dart';
import 'package:mydrive/MainDashboard/DashboardScreen.dart';
import 'package:mydrive/SharedFeature/dark_theme_provider.dart';
import 'package:mydrive/passcodeinitial.dart';
import 'package:mydrive/services/add_service.dart';
import 'package:mydrive/services/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "PasscodeStatus");
  String status = await storage.read(key: "LoginStatus");
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => AddService(),
      ),
    ], child: MyApp(value, status)),
  );
}

class MyApp extends StatefulWidget {
  String passstatus;
  String loginstatus;
  MyApp(this.passstatus, this.loginstatus);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAppTheme();
    FirebaseMessaging.instance.subscribeToTopic("notification");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          // home: ExtendedImageExample(),
          initialRoute: widget.passstatus == "true"
              ? "passcode"
              : widget.loginstatus == "true"
                  ? "/"
                  : "/login",
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          routes: {
            "/": (context) => DashboardScreen(),
            "/login": (context) => LoginScreen(),
            "passcode": (context) => PasscodeInitialScreen()
          },
        );
      }),
    );
    // return
  }
}
