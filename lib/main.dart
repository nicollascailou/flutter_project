
import 'package:flutter/material.dart';
import 'package:flutter_project/home_page_feed.dart';
import 'package:flutter_project/login_page.dart';
import 'package:flutter_project/register_pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/register_user_page.dart';
import 'package:flutter_project/welcome_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      "/": (context) => login_page(),
      "register_pet": (context) => register_pet(),
      "feed": (context) => home_page_feed(),
      "register": (context) => register_user_page(),
      "welcome": (context) => welcome_page(),
      // login ? cadastro,
      // recepção,
      // ((cadastro de pet ? gratificação) ? feed ? pets curtidos),
      // pagina de post ? gratificação
    },
  ));
}