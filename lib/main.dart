import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wow/View/splash_screen.dart';
import 'package:wow/services/push_notification.dart';
import 'View/Video_Call/calloing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Notificationservices n1 = new Notificationservices();
  FirebaseMessaging.instance.requestPermission();
  n1.reqPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Notificationservices n1 = new Notificationservices();

    FirebaseMessaging.onMessage.listen((message) {
      print("message" + message.notification!.title.toString());
      print("message" + message.notification!.body.toString());
      print("messagethyey" + message.data.toString());
    });
  return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: spalsh_scrren(),
    );
  }
}
