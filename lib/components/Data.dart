import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Data extends StatelessWidget{
  final String name;
  final String date;
  final String uid;
  final String id;
  Data(this.uid,this.name, this.date,this.id);
  FirebaseDatabase ref= FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new RaisedButton(
        color: Colors.white,
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 12.0),
                width: 45.0,
                height: 45.0,
                child: new CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      child: new Text(name[0].toUpperCase(),
                      style: TextStyle(fontSize: 28.0),)
                ),
              ),
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Text(this.name,style: TextStyle(fontSize: 20.0),),
                    new Text(this.date),
                  ],
                ),
              )
            ],
          ),
        ),
        onPressed: ()=> popupDelete(context),
      ),
    );
  }

  void popupDelete(context) {
    AlertDialog dialog = new AlertDialog(
      title: new Text('Done this work ?'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('Work Name : ${this.name}'),
          ],
        ),
      ),
      actions: <Widget>[
        new ButtonBar(
          children: <Widget>[
            new RaisedButton(
                onPressed: remove,
                color: Colors.blue,
                child: new Text("Yes")
            ),
            new RaisedButton(
                onPressed: ()=>cancel(context),
                color: Colors.redAccent,
                child: new Text("No")
            )
          ],
        )
      ],
    );
    showDialog(context: context,child: dialog);
  }

  void cancel(context) {
//    Navigator.pop(context);
  }
  void remove() {
    var x = ref.reference().child('flutter/${this.uid}/${this.id}').update({
      "status":1
    });
  }
}
