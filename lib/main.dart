import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/core/provider/auth_provider.dart' as provider;

import 'constants.dart';
import 'core/provider/home_provider.dart';
import 'core/router/router.dart';
import 'features/auth/login.dart';
import 'features/home/home.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    log("Handling a background message: ${message.notification!.title}");
    log("Handling a background message: ${message.notification!.body}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kAccentColor,
        statusBarIconBrightness: Brightness.dark));
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext ctx, Widget? child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => HomeProvider()),
                ChangeNotifierProvider(create: (_) => provider.AuthProvider()),
              ],
              child: Builder(
                builder: (BuildContext c) => MaterialApp(
                  title: 'Task',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  builder: (context, child) => Directionality(
                    textDirection: TextDirection.ltr,
                    child: child!,
                  ),
                  home: StreamBuilder<User?>(
                    stream: firebaseAuth.authStateChanges(),
                    builder: (BuildContext context, snapShot) =>
                        snapShot.data != null ? Home() : Login(),
                  ),
                ),
              ),
            ));
  }
}
