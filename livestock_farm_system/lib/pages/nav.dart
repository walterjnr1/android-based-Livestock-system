import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livestock_farm_system/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home2.dart';
import 'login.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}
class _NavState extends State<Nav> {

  /// This is the function we are using
  use() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = "${prefs.getString('username')}"; /// since you are using username
    Timer(
        Duration(seconds: 0),
            () {
          if(userToken!="null"){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Home2()));
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Login())); ///or login screen depending on you
          }
        }
    );
  }
  @override
  void initState(){
    super.initState();
    use(); /// we are calling the function in the initial state to make sure it loads before the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    );

  }
}
