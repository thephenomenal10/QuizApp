import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:quizapp/Authentication/SignInPage.dart';

class MyAppBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppBarState();
  }

}

class MyAppBarState extends State<MyAppBar>{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new AppBar(

      title: new Text("QUIZ",
        style: new TextStyle(
            color: (Colors.blue),
            fontSize: 30.0
        ),
      ),
      centerTitle: true,
      elevation: 4.0,
      backgroundColor: Colors.white,
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.exit_to_app,color: Colors.blue,size: 40, textDirection: TextDirection.rtl,), onPressed: signOut )
      ],
    );


  }


  Future<void > signOut() async{

    return  await _firebaseAuth.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
  }
}