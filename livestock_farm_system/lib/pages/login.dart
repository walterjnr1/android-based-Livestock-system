import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livestock_farm_system/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import '../model/data.dart';
import 'home2.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  TextEditingController txtusername_f = TextEditingController();
  TextEditingController txtpassword_f = TextEditingController();

  @override
  void dispose() {
    txtusername_f.dispose();
    txtpassword_f.dispose();

    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  Future login() async {
   // var url = "http://192.168.43.16/livestock_API/login.php";
    var url = "${Env.URL_PREFIX}/login.php";

    var response = await http.post(Uri.parse(url), body: {
      "txtusername": txtusername_f.text,
      "txtpassword": txtpassword_f.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', txtusername_f.text);

      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home2(),),);
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User(), ),);
    } else {
      Fluttertoast.showToast(
         msg: "Invalid Login details",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 3,
          textColor: Colors.white);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(

            elevation:0,
            title:
            Row(
              children: [
                const Expanded(child:Text("Login Form",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(' '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Register()));
                      },
                      child: const Text('Register',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),

                    )
                  ],
                ),
              ],
            ),
           // backgroundColor: Colors.greenAccent,
            backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
              automaticallyImplyLeading: false
          ),

          body:
          Container(

              child: Center(

                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Image.asset('assets/logo.png'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              controller: txtusername_f,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              controller: txtpassword_f,
                              obscureText: true,
                            ),
                          ),
                          Container(
                            height: 30,
                          ),

                       Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await Future.delayed(const Duration(seconds: 5));
                                  setState(() {
                                    isLoading = true;
                                    login();
                                  });
                                },
                                child: (isLoading)
                                    ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.9,
                                    )
                                )
                                    : const Text('Login'),
                              ),
                       ),


                          Container(
                            height: 50,
                          ),

                        ],
                      )
                  )
              )
          ),
        )
    );
  }
}


