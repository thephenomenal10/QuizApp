import 'package:quizapp/Authentication/SignUpPage.dart';
import 'package:quizapp/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}
class LoginPageState extends State<LoginPage> {

   FirebaseAuth _firebaseAuth;
   FirebaseUser _firebaseUser;

    bool _isLoading = false;

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF17ead9), Color(0xFF6078ea)],
                  // stops: [.1, 1],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 15.0, right: 15.0),
                child: Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 10,color: Colors.white,style: BorderStyle.solid),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                      ]),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 450,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(11, 6, 0, 10),
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ),
                            // Email
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                " Username",
                                style:
                                TextStyle(fontSize: 24, color: Colors.black),
                              ),
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Email',
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                                  contentPadding: EdgeInsets.all(10),
                                  focusColor: Colors.blueAccent),
                            ),
                            // Email end

                            //Password start
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                              child: Text(
                                " Password",
                                style:
                                TextStyle(fontSize: 24, color: Colors.black),
                              ),
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: validatePass,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.vpn_key),
                                  hintText: 'Password',
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                                  contentPadding: EdgeInsets.all(10),
                                  focusColor: Colors.blueAccent),
                            ),
                            //password end
                            SizedBox(height: 20.0,),
                            //Login Button
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF17ead9),
                                          Color(0xFF6078ea)
                                        ]),
                                        borderRadius: BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                              offset: Offset(0.0, 8.0),
                                              blurRadius: 8.0)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          signIn();
                                        } ,
                                        child: Center(
                                          child: Text("SIGNIN",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins-Bold",
                                                  fontSize: 18,
                                                  letterSpacing: 1.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account? ',
                                      style:
                                      TextStyle(color: Colors.black87, fontSize: 17)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                                    },
                                    child: Container(
                                      child: Text('Sign Up',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              decoration: TextDecoration.underline,
                                              fontSize: 17)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(value)){
      return 'Please enter a valid email id';
    }

  }

  String validatePass(String value) {

    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if(! regExp.hasMatch(value)){

      return "enter your passowrd correctly";
    }
  }


  void signIn() async{
    if(_formKey.currentState.validate()){
        _formKey.currentState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        print(result);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      } catch(e){
        return (e.message);
      }

    }

    }

  }
