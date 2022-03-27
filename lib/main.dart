import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'Screens/app_getting_started_screen.dart';
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /*FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);*/
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      home: GettingStartedScreen(),
    );
  }
}

