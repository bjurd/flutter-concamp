import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:concamp/screens/signup.dart';
import 'package:concamp/screens/login.dart';
import 'package:concamp/screens/home.dart';
import 'package:concamp/screens/create_post.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      initialRoute: "/signup",

      routes:
      {
        "/signup": (context) => SignUp(),
        "/login": (context) => Login(),
        "/home": (context) => Home(),
        "/make": (context) => CreatePost()
      }
  ));
}
