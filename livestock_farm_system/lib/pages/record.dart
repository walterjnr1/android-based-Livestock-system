import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/data.dart';
import '../model/search.dart';
import '../model/searchlivestock.dart';
import 'login.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;


class Records extends StatefulWidget {
  const Records({Key? key, livestock}) : super(key: key);

  @override
  RecordsState createState() => RecordsState();
}

class RecordsState extends State<Records> {
  TextEditingController txtsearch_f = TextEditingController();
  String total_livestock = "0";
  List<Livestock> liveStocks = [];
  String query = '';


  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));
  }
  late Future<List<Livestock>> livestock;
 //late Future<List<Livestock_search>> livestock_search;

  final livestockListKey = GlobalKey<RecordsState>();
 // final livestockListKey_search = GlobalKey<RecordsState>();

  @override
  void initState() {
    super.initState();
    livestock = getLivestockList();
   }

  Future<List<Livestock>> getLivestockList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username_value = prefs.getString('username');


    //final response = await http.get(Uri.parse(("${Env.URL_PREFIX}/select_livestock.php")));

    final response = await http.get(Uri.parse(("${Env.URL_PREFIX}/select_livestock.php?username=${username_value}")));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Livestock> livestock = items.map<Livestock>((json) {
      return Livestock.fromJson(json);
    }).toList();
    setState(() {
      total_livestock = "${livestock.length}";
      liveStocks = livestock;
    });

    return livestock;
  }

    Future<List<Livestock_search>> getLivestockList_search() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username_value = prefs.getString('username');
    final response = await http.get(Uri.parse(("${Env_search.URL_PREFIX}/search.php?query=${txtsearch_f.text}&username=${username_value}")));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Livestock_search> livestock_search = items.map<Livestock_search>((json) {
      return Livestock_search.fromJson(json);
    }).toList();
    setState(() {
      total_livestock = "${livestock_search.length}";
    });

    List<Livestock> livestock = items.map<Livestock>((json) {
      return Livestock.fromJson(json);
    }).toList();
    setState(() {
      liveStocks = livestock;
    });

    return livestock_search;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                const Expanded(child:Text("MY LIVESTOCK RECORD",
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
       Center(
          // padding: const EdgeInsets.all(16),
    child:SingleChildScrollView(
      padding: const EdgeInsets.all(20),

    scrollDirection: Axis.vertical,
    child: Column(
    children: [
      Container(
        height:40.0,
        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
        alignment: Alignment.center,
        child:  TextField(
          onChanged: (query) {
           getLivestockList_search();
           setState(() {
             txtsearch_f.text.isEmpty ? getLivestockList() : getLivestockList_search();
           });

          },
          controller: txtsearch_f,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search Livestock",
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: (){
                  txtsearch_f.text="";
                  setState(() {
                    txtsearch_f.text.isEmpty ? getLivestockList() : getLivestockList_search();
                  });
                },
                icon: Icon(Icons.cancel),
              ),

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)
                  )
              )
          ),

        ),

      ),

      Container(
        height:40.0,
        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
        alignment: Alignment.center,
        child:  Text('Livestock Count: ${total_livestock}',
          style: TextStyle(
            fontSize: 12.5,
            //height: 3.5, //You can set your custom height here
            color: Colors.black,

          ),
        ),

      ),
    Container(
                  height: 20,
                ),
    displayList()
    ]
          ),
        )
        )
    );

  }

  Widget displayList(){
    return  ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: liveStocks.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data =liveStocks[index];

                              //delete health status
                              void deleteLivestock(context) async {
                                await http.post(Uri.parse("${Env.URL_PREFIX}/delete_livestock.php"),

                                  body: {
                                    'txtlivestock_no': data.livestock_no.toString(),
                                  },
                                );
                                // Navigator.pop(context);
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                              }
                              void confirmDelete(context) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text('Are you sure you want to delete this?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Icon(Icons.cancel),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),

                                        ),
                                        ElevatedButton(
                                          child: const Icon(Icons.check_circle),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () => deleteLivestock(context),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              //Update health status
                              void updateLivestock(context) async {
                                await http.post(Uri.parse("${Env.URL_PREFIX}/edit_livestock.php"),

                                  body: {
                                    'txtlivestock_no': data.livestock_no.toString(),
                                  },
                                );
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                                // Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const Records(),
                                  ),
                                );
                              }
                              void confirmUpdate(context) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text('Are you sure you want to Update health Status of this Livestock ?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Icon(Icons.cancel),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                        ElevatedButton(
                                          child: const Icon(Icons.check_circle),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () => updateLivestock(context),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

        return Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color.fromRGBO(49, 87, 110, 1.0),
                width: 2,//<-- SEE HERE
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),

            elevation: 5,

                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10,
                                      ),
                                      Text('Livestock Name: ${data.name}',
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),

                                      Container(
                                        height: 5,
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
                                          radius: 20,
                                          child: Text('${index + 1}'),
                                          //child: Text('1'),

                                        ),
                                      ),
                                      Container(
                                        // height: 20.0,
                                        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
                                        alignment: Alignment.center,
                                        child: Text('Sex: ${data.sex}',


                                            style: TextStyle(
                                            fontSize: 12.5,
                                            //height: 3.5, //You can set your custom height here
                                            color: Colors.black,

                                          ),
                                        ),

                                      ),
                                      Container(
                                        // height: 20.0,
                                        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
                                        alignment: Alignment.center,
                                        child: Text('Weight: ${data.weight}+kg',
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            //height: 3.5, //You can set your custom height here
                                            color: Colors.black,

                                          ),
                                        ),

                                      ),
                                      Container(
                                        height: 20.0,
                                        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
                                        alignment: Alignment.center,
                                        child: Text('Livestock No: ${data.livestock_no}',
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.black,

                                          ),
                                        ),

                                      ),
                                      Container(
                                        height: 20.0,
                                        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
                                        alignment: Alignment.center,
                                        child: Text('Health Status: ${data.status}',
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            //height: 3.5, //You can set your custom height here
                                            color: Colors.black,

                                          ),
                                        ),

                                      ),
                                      Container(
                                        height: 20.0,
                                        padding: const EdgeInsets.fromLTRB(13.0,2.0,2.0,2.0),
                                        alignment: Alignment.center,
                                        child: Text('Registtration Date: ${data.date_register}',
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.black,

                                          ),
                                        ),

                                      ),
                                      Container(
                                        height: 20.0,
                                      ),


                                      ButtonBar(
                                        alignment: MainAxisAlignment.spaceBetween,
                                        buttonPadding:const EdgeInsets.symmetric(
                                        ),
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          TextButton.icon(
                                            icon: const Icon( Icons.edit,color: Colors.black, size: 14,),
                                            label: Text('Update Status',
                                                style: TextStyle(fontSize: 10,
                                                    color: Colors.black)
                                            ),
                                             onPressed: () => confirmUpdate(context),


                                          ),
                                          TextButton.icon(
                                            icon: const Icon( Icons.delete_forever,color: Colors.black, size: 14,),
                                            label: const Text('',
                                                style: TextStyle(fontSize: 10,
                                                    color: Colors.black)
                                            ),
                                            onPressed: () => confirmDelete(context),


                                          ),
                                        ],
                                      )
                                    ],
                                  )
         );
                                    },
                          );
  }

  }