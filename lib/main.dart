// ignore_for_file: prefer_const_constructors

// import 'package:earnily/google_signin.dart';
import 'package:earnily/firebase_options.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// import 'firebase_options.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earnily',
      home: SignInScreen(),
    );
  }
}
