import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home2.dart';
import 'login.dart';



class WelcomeScreen extends StatefulWidget {
  const   WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  Future<String> getUser() async{
    await Future.delayed(const Duration(seconds: 6));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('username') ?? ""; /// since you are using username
    debugPrint("login in as ${userToken}");
    return userToken;
  }
  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }


  final String welcometext =
      "Developed by Ndueso Walter, \n\n "
      "Reg No:822832323 ,Dept:- computer Science, \n\n"
  "Authur Javis University, calabar \n\n";
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:FutureBuilder<String>(
          future: getUser(),
          builder:((context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done){
              return splash();
            }else{
              if(snapshot.data==null || snapshot.data!.isEmpty){

                return Login();
              }
              return Home2();
            }
          }),
        )

    //     body:  Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //
    //     title:  const Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Text(
    //           "DESIGN AND IMPLEMENTATION OF\n\n  "
    //         "ANDROID-BASED LIVESTOCK FARMING SYSTEM \n\n ",
    //
    //         style: TextStyle(
    //           fontSize: 13.5,
    //           height: .6,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ),
    // backgroundColor: Colors.white,
    // elevation: 0,
    // ),
    //
    //
    //
    // )
    );
  }

  Widget splash(){
    return Row(
        children: [
          Flexible(
            child: EasySplashScreen(
              logo: Image.asset('assets/1.jpg'),
              logoSize: 160.0,
              title: Text(welcometext,
                style: const TextStyle(
                  fontSize: 14,
                  //fontWeight: FontWeight.bold,
                ),

              ),

              backgroundColor: Colors.white60,
              showLoader: true,
              loadingText: const Text("Loading..."),
              // navigator: const Nav(),
              // durationInSeconds: 8,

            )

        )
    ]
        );

  }
}