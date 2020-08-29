import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quoto/routes.dart';
import 'package:quoto/screens/main_screen.dart';

//As to initialize firebase in recent upgarades: https://github.com/FirebaseExtended/flutterfire/issues/3235
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink.shade50,
      ),
      home: MainScreen(),
      initialRoute: MainScreen.routeName,
      routes: routes,
    );
  }
}
