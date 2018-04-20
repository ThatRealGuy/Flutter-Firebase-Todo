import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_todo/components/Data.dart';
import 'package:firebase_todo/components/Done.dart';
import 'package:flutter/material.dart';
import 'package:firebase_todo/pages/Task.dart';
import 'package:firebase_todo/pages/Login.dart';
class Home extends StatefulWidget{
  Home();
  @override
  State<Home> createState() {
    return new HomeState();
  }
}
class HomeState extends State<Home>{
  final List<Data> _work = <Data>[];
  final List<Done> _done = <Done>[];
  DatabaseReference ref= FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future _get() async{
    FirebaseUser user = await _auth.currentUser();
    ref.child('flutter/${user.uid}').onValue.listen((snapshot){
      _work.clear();
      _done.clear();
      print(_work.length);
      print(_done.length);

      var snap = snapshot.snapshot;
      var keys = snap.value.keys;
      for(var key in keys)
        snap.value[key]['status']==0?_work.add(new Data(
            user.uid,
            snap.value[key]['name'],
            snap.value[key]['date'],
            key
          )
        ):snap.value[key]['status']==1?_done.add(new Done(
            user.uid,
            snap.value[key]['name'],
            snap.value[key]['date'],
            key
        )):null;
      setState(() {
        print(_work.length);
        print(_done.length);
      });
    });
  }
  void quit(){

  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.pink
     ),
     home: new DefaultTabController(
       length: 2,
       child: new Scaffold(
         appBar: new AppBar(
           title: new Text("Firebase Todo"),
           actions: <Widget>[
             new FlatButton(
                 child: new Text("Logout"),
                 onPressed: ()=>_logout(),
                  textColor: Colors.white,
             )
           ],
           bottom: new TabBar(
               tabs: [
                 new Tab(child: new Text("To Do")),
                 new Tab(child: new Text("Done "))
               ]
           ),
         ),
         body: new TabBarView(
             children:[
               new Container(
                 child: new ListView.builder(
                     padding: new EdgeInsets.all(8.0),
                     itemBuilder: (_, int index) => _work[index],
                     itemCount: _work.length,
                   ),
               ),
               new Container(
                 child: new ListView.builder(
                   padding: new EdgeInsets.all(8.0),
                   itemBuilder: (_, int index) => _done[index],
                   itemCount: _done.length,
                 ),
               ),
             ]
         ),
         floatingActionButton: new FloatingActionButton(
           onPressed: _createTask,
           tooltip: 'Add new Task',
           backgroundColor: Colors.pink,
           child: new Icon(Icons.add,color: Colors.white,),
         ),
       ),
     ),
   );
  }
  void _createTask() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => Task()),);
  }

  @override
  void initState() {
    super.initState();
    _get();
  }
  _logout(){
    AlertDialog dialog = new AlertDialog(
      title: new Text('Conform Logout'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('Want to Logout ?'),
          ],
        ),
      ),
      actions: <Widget>[
        new ButtonBar(
          children: <Widget>[
            new RaisedButton(
                onPressed: do_logout,
                color: Colors.blue,
                child: new Text("No")
            ),
            new RaisedButton(
                onPressed: ()=>_auth.signOut(),
                color: Colors.redAccent,
                child: new Text("Yes")
            )
          ],
        )
      ],
    );
    showDialog(context: context,child: dialog);
  }
  void do_logout() {
    _auth.signOut();
    Navigator.push(context, new MaterialPageRoute(builder: (context) => Login()),);
  }
}
