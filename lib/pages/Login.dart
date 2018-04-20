import 'dart:async';
import 'package:firebase_todo/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget{
  Login();
  @override
  State<Login> createState() {
    return new LoginState();
  }

}

class LoginState extends State<Login>{
  final TextEditingController _email_r = new TextEditingController();
  final TextEditingController _pass_r = new TextEditingController();
  final TextEditingController _email_l = new TextEditingController();
  final TextEditingController _pass_l = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    if(!user.isAnonymous){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()),);
    }
    return user;
  }
  Future _login(String email,String pass) async{
    FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    if(!user.isAnonymous){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()),);
    }
    return user;
  }
  Future _register(String email,String pass) async{
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    if(!user.isAnonymous){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()),);
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Login",
        theme: ThemeData(
            primarySwatch: Colors.pink
        ),
      home: new DefaultTabController(
          length: 2,
          child: new Scaffold(
            appBar: AppBar(
              title: Text("TODO App"),
              bottom: new TabBar(
                  tabs: [
                    new Tab(child: Text("Regsiter")),
                    new Tab(child: Text("Login")  )
                  ]
              ),
            ),
            body: new TabBarView(
                children: [
                  _registerUI(),
                  _loginUI(),
                ]
            ),
          )
      )
    );
  }
  Widget _loginUI(){
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new Container(
            child: new Text("Login",style: new TextStyle(fontSize: 40.0),),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 20.0)),
          new TextField(
              controller: _email_l,
              decoration:new InputDecoration(hintText: "Enter Your Email")
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new TextField(
              controller: _pass_l,
              decoration:new InputDecoration(hintText: "Enter Your Password")
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new RaisedButton(
            onPressed: () => _login(_email_l.text,_pass_l.text),
            child: new Text("Login"),
            padding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 12.0),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new Container(
            child: new RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
              onPressed: _signIn,
              textColor: Colors.white,
              color: Colors.red,
              child: new Text("Login with Gooogle"),
            ),
          )
        ],
      ),
    );
  }

  Widget _registerUI(){
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new Container(
            child: new Text("Register",style: new TextStyle(fontSize: 40.0),),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 20.0)),
          new TextField(
              controller: _email_r,
              decoration:new InputDecoration(hintText: "Enter Your Email")
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new TextField(
              controller: _pass_r,
              decoration:new InputDecoration(hintText: "Enter Your Password")
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new RaisedButton(
            onPressed: () => _register(_email_r.text,_pass_r.text),
            child: new Text("Register"),
            padding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 12.0),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0)),
          new Container(
            child: new RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
              onPressed: _signIn,
              textColor: Colors.white,
              color: Colors.red,
              child: new Text("Register with Gooogle"),
            ),
          )
        ],
      ),
    );
  }

}