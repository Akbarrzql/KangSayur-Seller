import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kangsayur_seller/ui/auth/password/ganti_password.dart';
import 'package:kangsayur_seller/ui/auth/register/driver/reset_pasword_driver.dart';
import 'package:kangsayur_seller/ui/splash_screen/splash_screen.dart';
import 'package:kangsayur_seller/ui/transaksi/transaksi.dart';

import 'firebase/firebase_messaging.dart';
import 'firebase/firebase_notification.dart';
import 'firebase/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PushNotificationConfig().requestPermission();
  await PushNotificationConfig().androidNotificationChanel();
  await initializeDateFormatting();
  await FirebaseNotificationManager.initializeFirebase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // FirebaseNotificationManager.configureForegroundMessaging();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final PendingDynamicLinkData? initialLink =
  await dynamicLinks.getInitialLink();
  _handleDeepLink(initialLink);

  dynamicLinks.onLink.listen((dynamicLink) {
    _handleDeepLink(dynamicLink);
  }, onError: (e) {
    print('onLinkError');
    print(e.message);
  });

  _handleDeepLink(initialLink);
}

void _handleDeepLink(PendingDynamicLinkData? data) {
  final Uri? uri = data?.link;
  print('uri: $uri');
  if (uri != null && uri.path == '/') {
    runApp(const MaterialApp(
      home: GantiPasswordPage(),
    ));
  } else {
    runApp(const MyApp());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
