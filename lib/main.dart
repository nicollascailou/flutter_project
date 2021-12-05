import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/pet_bloc.dart';
import 'package:flutter_project/bloc/user_bloc.dart';
import 'package:flutter_project/home_page_feed.dart';
import 'package:flutter_project/login_page.dart';
import 'package:flutter_project/register_pet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/register_user_page.dart';
import 'package:flutter_project/user_profile_form.dart';
import 'package:flutter_project/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PetBloc(),
      ),
      BlocProvider(
        create: (context) => UserBloc(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "register_pet": (context) => RegisterPet(),
        "feed": (context) => home_page_feed(),
        "register": (context) => RegisterUserPage(),
        "welcome": (context) => WelcomePage(),
        "userForm": (context) => UserProfileForm(""),
      },
    ),
  ));
}
