import 'package:flutter/material.dart';
import './auth/register.dart';
import './auth/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main()async {
  await DotEnv().load('.env');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Guru",
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/register": (context) => Register()
      }));
}


