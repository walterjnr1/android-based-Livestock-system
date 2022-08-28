import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/data.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;

  TextEditingController txtweight_f = TextEditingController();

  Future register() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username_value = prefs.getString('username');
    //var url = "http://192.168.43.16/livestock_API/register.php";
    var url = "${Env.URL_PREFIX}/register.php";

    debugPrint(username_value);
    var response = await http.post(Uri.parse(url),
    body:
       {
         "txtusername": username_value,
      "cmdname": selectedLivestock,
      "cmdsex": selectedSex,
      "cmdstatus": selectedStatus,
       "txtweight": txtweight_f.text,
    });
    var data = json.decode(response.body);
    if (data == "success") {
     Fluttertoast.showToast(
         msg: "Registration was successful",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
         timeInSecForIosWeb: 3,
         textColor: Colors.white);

      selectedLivestock="";
      selectedSex="";
      selectedStatus="";
      txtweight_f.text='';

    } else if (data == "livestock Number Already Exist"){
      Fluttertoast.showToast(
          msg: "livestock Number Already Exist",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 3,
          textColor: Colors.white);
    }else{
      Fluttertoast.showToast(
          msg: "Something Went wrong",
         toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 3,
          textColor: Colors.white);
    }
  }

  String selectedLivestock = "Select Cattle";
  List<DropdownMenuItem<String>> get dropdownItems1{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select Cattle"),value: "Select Cattle"),
      const DropdownMenuItem(child: Text("Cattle"),value: "Cattle"),
      const DropdownMenuItem(child: Text("Sheep"),value: "Sheep"),
      const DropdownMenuItem(child: Text("Pig"),value: "Pig"),
      const DropdownMenuItem(child: Text("Goat"),value: "Goat"),
    ];
    return menuItems;
  }

  String selectedSex = "Select Sex";
  List<DropdownMenuItem<String>> get dropdownItems2{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select Sex"),value: "Select Sex"),
      const DropdownMenuItem(child: Text("Male"),value: "Male"),
      const DropdownMenuItem(child: Text("Female"),value: "Female"),
    ];
    return menuItems;
  }

  String selectedStatus = "Select Status";
  List<DropdownMenuItem<String>> get dropdownItems3{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select Status"),value: "Select Status"),
      const DropdownMenuItem(child: Text("Healthy"),value: "Healthy"),
      const DropdownMenuItem(child: Text("Sick"),value: "Sick"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

          title:
              Row(
                children: [
                  const Expanded(child:Text("Register Your Livestock",
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));
                        },
                        child: const Text('Logout',
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
              backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),

             // backgroundColor: Colors.greenAccent,
              leading:

              IconButton(
                icon: CircleAvatar(backgroundColor: Colors.greenAccent[100],
                  radius: 30,
                  child:
                  const Icon(Icons.arrow_back),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              )

          ),

          body:

          //TabBarView(
          //children: [
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
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),

                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedLivestock,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedLivestock = newValue!;
                                      });
                                    },

                                    items: dropdownItems1)

                            ),

                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),

                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedSex,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedSex = newValue!;
                                      });
                                    },

                                    items: dropdownItems2)

                            ),

                          ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Weight',
                              ),
                            controller:   txtweight_f,
                            ),
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),

                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedStatus,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedStatus = newValue!;
                                      });
                                    },
                                    items: dropdownItems3)

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
                                    register();
                                    isLoading = false;

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
                                    : const Text('Register'),
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

          // ]
          //)

        )
    );
  }
}