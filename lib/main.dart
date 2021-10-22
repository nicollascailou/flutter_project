
import 'package:flutter/material.dart';
import 'package:flutter_project/home_page_feed.dart';
import 'package:flutter_project/register_pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      "/": (context) => home_page_feed(),
      "register_pet": (context) => register_pet(),
    },
  ));
}