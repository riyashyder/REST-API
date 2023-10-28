import 'dart:convert';

import 'package:flutter/material.dart';

import 'model.dart';

import 'package:http/http.dart' as http;



void main()=>runApp(MyApp());
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Person> person;

  @override
  void initState(){
    super.initState();
    print('+++++++++++++++++initial state');
    person = fetchPerson();
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter REST API Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Flutter REST API Binding',
            ),
          ),
          body: Center(
            child: FutureBuilder<Person>(
              future: person,
              builder: (context,indexPerson){
                if(indexPerson.hasData){
                  return Text(indexPerson.data!.title.toString());
                }else if(indexPerson.hasError){
                  return Text('${indexPerson.error}');
                }
                //it show a loading spinner
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
    );
  }
}

Future<Person> fetchPerson() async{
  final _authority = 'jsonplaceholder.typicode.com';
  final _path = '/albums/1';
  final _uri = Uri.https(_authority,_path);
  final response = await http.get(_uri);
  print("----HTTP URL -----${_uri.toString()}");
  
  if(response.statusCode==200) {
    print('---RESPONSE BODY -----${response.body}');
    return Person.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to Load album');
    
  }

}

