import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:livestock_farm_system/pages/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import 'login.dart';
import 'register.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


Future<User> fetchUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username_value = prefs.getString('username');
  final response = await http.get(Uri.parse(("${Env.URL_PREFIX}/get_user_details.php?username=${username_value}")));


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,

    // then parse the JSON.
    var res = jsonDecode(response.body) as List;
    debugPrint(response.body);
    return User.fromJson(res[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}
class _Home2State extends State<Home2> {


  //display Dialogdbox
  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Report Animal'),
            content: Text('This Module is under development. Thanks '),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }
  _dismissDialog() {
    Navigator.pop(context);
  }
  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));

  }

  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();

  }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child:Text("USER DASHBOARD",
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
                    logout();
                  },
                  child: const Text('Logout',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                )
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),

      ),
      body: Container(
      padding: const EdgeInsets.all(7),

      child: Column(

      children: [

      const SizedBox(height: 11),


      FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
      if (snapshot.hasData) {
             return  Text("Name Of Farm : ${snapshot.data!.poultry_name}",
      //return const Text("Name Of Farm :",

      style: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      ),
      );
      } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const CircularProgressIndicator();
      },
      ),

        ]//<------
      ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.contain
            )
        ),
    ),

      drawer: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {

              return snapshot.connectionState==ConnectionState.done ?  UserAccountsDrawerHeader(
              accountName:  Text(snapshot.data!.fullname),
              accountEmail:  Text(snapshot.data!.email),
              currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                           "${Env.URL_PREFIX}/${snapshot.data!.photo}",
                          //"https://protocoderspoint.com/wp-content/uploads/2019/10/mypic-300x300.jpg",

                        width: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/cow.jpg')
                    ),
                  ),
              ):Text("log");
     }
  ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home2()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('livestock Registration'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Register()));
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.pets_sharp),
              title: const Text('Detailed Livestock Record'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Records()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.whatsapp),
              title: const Text('Report Animal'),
              onTap: () {
               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Records()));
              //},
             // onPressed: () {
                _showMaterialDialog();
              },
            ),
            const Divider(),

          ],
        ),
      ),
    );
  }
}
