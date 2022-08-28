import "package:flutter/material.dart";
import 'package:livestock_farm_system/pages/home2.dart';
import 'package:livestock_farm_system/pages/login.dart';
import 'package:livestock_farm_system/pages/record.dart';
import 'package:livestock_farm_system/pages/register.dart';
import 'package:livestock_farm_system/pages/welcome.dart';


void main() =>  runApp(  MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    
  '/': (context) =>   const WelcomeScreen(),
 '/register': (context) =>   const Register(),
 '/home': (context) =>   const Home2(),
   '/login': (context) =>   const Login(),
   '/record': (context) =>   const Records(),

  },
));
