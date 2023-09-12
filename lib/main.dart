import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseAppCheck.instance.getToken();
    await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.playIntegrity);
  } catch (e) {
    print('\n\nPrinting From App: \nError during Firebase initialization: $e \n \n \n');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application..-
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cancer Project',
      //theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //  useMaterial3: true,
      //),
      debugShowCheckedModeBanner: false,
      home: SplashScreenWidget(),
    );
  }
}
