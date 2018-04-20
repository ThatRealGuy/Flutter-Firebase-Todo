import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/pages/Login.dart';
import 'package:firebase_todo/pages/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.white
      ),
      home: new Todo(),
    );
  }
}

class Todo extends StatefulWidget{
  @override
  State<Todo> createState() {
    return new TodoState();
  }
}

class TodoState extends State<Todo>{
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
    Future checkLogin() async{
    FirebaseUser user = await _auth.currentUser();
    if(user!=null && !user.isAnonymous ){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()),);
    }else{
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Login()),);
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.pink,
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: new Text("Todo List",style: new TextStyle(fontSize: 72.0,color: Colors.white),),
              ),
              new Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: new Text("Cloud || Firebase",style: new TextStyle(fontSize: 28.0,color: Colors.grey)),
              ),
              new Container(
              width: 80.0,
                height: 80.0,
                child: new CircularProgressIndicator(strokeWidth: 8.0,backgroundColor: Colors.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
