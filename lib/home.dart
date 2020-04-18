import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>{

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body:RaisedButton(child: Text("LogOut"),
      onPressed: ()async{
        sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.clear();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Guru()), (Route<dynamic> route) => false);
      },
      )
    );
  }
}