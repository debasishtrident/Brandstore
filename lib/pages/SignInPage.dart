import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brandstore/pages/HomePage.dart';
import 'package:brandstore/pages/PasswordResetPage.dart';
import 'package:brandstore/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

// Async function that calls getSharedPreferences
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final databaseReference = Firestore.instance;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Signing User...', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          color: Colors.black26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Logoicon(),
              Textforintro(),
              Username(),
              Password(),
              Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 40.0,
                    margin: EdgeInsets.only(left: 15.0, top: 20.0),
                    child: RaisedButton(
                      color: Color(0xFFceced8),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFFceced8))),
                      onPressed: () {
                        _signInWithEmailAndPassword();

                      },
                      child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child:Forgetpassword(),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassReset(),));
                    },
                  ),

                ],
              ),
              DontHaveAnAccountYet(),
              SignUpbutton(),
            ],
          ),
        ),
      ),
    );
  }
  void _signInWithEmailAndPassword() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    try {
      await pr.show();
      pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim(),)).user;
      if (user.isEmailVerified) {
        Fluttertoast.showToast(msg: "Login successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.teal,textColor: Colors.white);
         SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        await pr.hide();

        databaseReference.collection(user.email).document("PersonalInfo").updateData({
          'lastlogin': date,
         }
        );

        Navigator.of(context).pop();
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(username: user.email )),);
      }
      else if(!user.isEmailVerified){
        await pr.hide();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("OOPS!",style: TextStyle(color: Colors.white,fontSize: 20),),
                content: Text("Looks like you didn't confirm your mail yet",style: TextStyle(color: Colors.white,fontSize: 17),),
                actions: <Widget>[
                  FlatButton( onPressed: (){
                    Navigator.pop(context);
                   },
                    child: Text("Dismiss",style: TextStyle(color: Colors.white,fontSize: 17),),),
                  FlatButton(onPressed: () async {
                    Navigator.pop(context);
                    await user.sendEmailVerification();
                    Fluttertoast.showToast(msg: "Verification email send succesfully", gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT);
                   },child: Text("Confirm Now",style: TextStyle(color: Colors.white,fontSize: 17),),),
                ],
                elevation: 24.0,
                backgroundColor: Colors.blue,
              );
            }
        );
      }
      else {
        await pr.hide();
        Fluttertoast.showToast(msg: "Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.teal,textColor: Colors.white);

      }
    } catch (e) {
      await pr.hide();
      Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.teal,textColor: Colors.white);
     }

  }
}
class Logoicon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage("images/logo1.png");
    Image image = Image(
      image: assetImage,
    );
    final margintop=MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: margintop*0.3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: image,
        ),
      ),
    );
  }
}

class Textforintro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.0),
        child: Center(
          child: Text(
            "BrandStore.com",

            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30.0,
                color: Colors.white,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700),
          ),
        ));
  }
}

class Username extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 25.0, right: 10.0, bottom: 10.0),
      child: Material(
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 0.0),
            hintText: "Gmail",
            border: InputBorder.none,
            icon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 45.0,
      margin: EdgeInsets.all(10.0),
      child: Material(
        child: TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 0.0),
            hintText: "Password",
            border: InputBorder.none,
            icon: Icon(Icons.lock),
          ),
        ),
      ),
    );
  }
}
class Forgetpassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 25.0, top: 20.0),
      child: Text(
        "Forgot Password ?",

        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15.0,
            color: Colors.white,
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
class DontHaveAnAccountYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        child: Text(
          "Dont Have an Account Yet ?",

          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 15.0,
              color: Colors.white,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
class SignUpbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: 300.0,
        height: 50.0,
        margin: EdgeInsets.only(top: 30.0, bottom: 30),
        child: RaisedButton(
          color: Color(0xFFceced8),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15),
              side: BorderSide(color: Color(0xFFceced8))),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child: Text(
            'Register here..',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
