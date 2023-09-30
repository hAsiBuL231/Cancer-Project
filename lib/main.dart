import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug);
    //print('\n  Step: 0 \n ');
    await FirebaseAppCheck.instance.getToken(true);
    //print('\n  Step: 1 \n ');
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    //print('\n  Step: 2 \n ');
    await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.playIntegrity);
    //print('\n  Step: 3 \n ');
  } catch (e) {
    if (kDebugMode) {
      print('\n \n Printing From App:  Error during Firebase initialization: \n $e \n \n \n');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application..-
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cancer Hope',
      //theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //  useMaterial3: true,
      //),
      debugShowCheckedModeBanner: false,
      //color: Colors.white,
      home: SplashScreenWidget(),
    );
  }
}
