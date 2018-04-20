import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget{
  Task();
  @override
  State<Task> createState() {
    return new TaskState();
  }
}

class TaskState extends State<Task>{
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _date = new TextEditingController();
  FirebaseDatabase ref= FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future _save(String name,String date) async{
    _name.clear();
    _date.clear();
    FirebaseUser user = await _auth.currentUser();
    var db = ref.reference().child('flutter/${user.uid}').push();
    db.set({
      "name":name,
      "date":date,
      "status":0,
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: new Scaffold(
        appBar: AppBar(
          title: new Text("Add Task"),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              _registerUI(),
            ],
          )
        ),
      )
    );
  }

  Widget _registerUI(){
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _form(),
        ],
      ),
    );
  }

  Widget _form(){
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: new Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
          new Text(
            "Todo",
            style: TextStyle(fontSize: 40.0),
          ),
          new TextField(
              controller: _name,
              decoration:new InputDecoration(hintText: "What to do ? ")
          ),
          new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          new TextField(
              controller: _date,
              decoration:new InputDecoration(hintText: "When to do ?")
          ),
          new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          new RaisedButton(
            onPressed: ()=>_save(_name.text,_date.text),
            child: new Text("Add"),
          ),
          new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          _message()
        ],
      ),
    ) ;
  }
  Widget _message(){
    return new Container(

    );
  }
}