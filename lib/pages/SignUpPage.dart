
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brandstore/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _cnfpasswordController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class RegisterPage extends StatefulWidget {
   @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  ProgressDialog pr;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

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

    return Scaffold(
      appBar: AppBar( title: Text("Registration"),backgroundColor: Color(0xff0f4c81)),

      body:
          SingleChildScrollView(
            child:  Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Logoicon(),
                  emailfield(),
                  passwordfield(),
                  cnfpasswordfield(),
                  phonefield(),
                  namefield(),
                 Center(
                   child:  Container(
                     width: 300,
                     height: 50,
                     margin: EdgeInsets.only(top: 25,bottom: 30),
                     child: RaisedButton(
                       color: Color(0xFFceced8),
                       shape: RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(0.0),
                           side: BorderSide(   color: Color(0xFFceced8))
                       ),
                       onPressed: () async {
                         var pass = _passwordController.text;
                         var cnfpass = _cnfpasswordController.text;
                         if (pass==cnfpass){
                           if (_formKey.currentState.validate()) {

                              _register();


                           }
                         }
                         else{
                           Fluttertoast.showToast(msg:"Confirm password didn't match",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                               backgroundColor: Colors.teal,textColor: Colors.white);
                          }


                       },
                       child: Text('Submit',style: TextStyle(
                           color: Colors.white,fontFamily: "Raleway",fontWeight: FontWeight.w600
                       ),
                       ),
                     ),
                   ),
                 ),

                ],
              ),
            ),
          ),

    );
  }


  // Example code for registration.
   void _register() async {
     await pr.show();
     pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
    var gmail= _emailController.text;
    var pass= _passwordController.text;
    var name= _nameController.text;
    var phone= _phoneController.text;

    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )).user;

      if (user!=null) {

        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format(DateTime.now());

        var rand=new Random();
        int cvv1=rand.nextInt(10000);
        int cvv2=rand.nextInt(1000);

        Fluttertoast.showToast(msg:"Registered successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,textColor: Colors.teal);

        databaseReference.collection(user.email).document("PersonalInfo").setData({
          'email': gmail,
          'password': pass,
          "name": name,
          "phone": phone,
          "usercreated":date,
          "lastlogin":date,
          "cvv1":cvv1,
          "cvv2":cvv2,
          "dob": "",
          "gender":"",
          "address1":"",
          "address2":"",

          "profilePic":""
        });



        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        await pr.hide();
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyHomePage(username: user.email),),);

      }
      else {
        await pr.hide();
        Fluttertoast.showToast(msg:"Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,textColor: Colors.teal);
       }



    }
    catch(e) {
      await pr.hide();
      Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,textColor: Colors.teal);
     }

    }



}
class Logoicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=AssetImage("images/logo1.png");
    Image image=Image(image: assetImage,);
    return Center(
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50.0,bottom: 30),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: image,
        ),
      ),
    );
  }
}
class emailfield extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 7),

      decoration: BoxDecoration(
          color: Color(0xFFceced8),
          borderRadius: new BorderRadius.all(Radius.circular(10))
      ),
      child:   TextFormField(
        controller: _emailController,

        decoration: const InputDecoration(labelText: 'Gmail',border:InputBorder.none, ),

      ),
    );
  }

}
class passwordfield extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 7),

      decoration: BoxDecoration(
          color: Color(0xFFceced8),
          borderRadius: new BorderRadius.all(Radius.circular(10))
      ),
      child:   TextFormField(
        maxLines: 1,
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(labelText: 'Password',border:InputBorder.none),

      ),
    );
  }

}
class cnfpasswordfield extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 7),

      decoration: BoxDecoration(
          color: Color(0xFFceced8),
          borderRadius: new BorderRadius.all(Radius.circular(10))
      ),
      child:   TextFormField(
        controller: _cnfpasswordController,
        decoration: const InputDecoration(labelText: 'Confirm Password',border:InputBorder.none),

      ),
    );
  }

}
class phonefield extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 7),

      decoration: BoxDecoration(
          color: Color(0xFFceced8),
          borderRadius: new BorderRadius.all(Radius.circular(10))
      ),
      child:   TextFormField(
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        decoration: const InputDecoration(labelText: 'Phone',border:InputBorder.none),

      ),
    );
  }

}
class namefield extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 7),

      decoration: BoxDecoration(
          color: Color(0xFFceced8),
          borderRadius: new BorderRadius.all(Radius.circular(10))

      ),
      child:   TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Name',border:InputBorder.none,

        ),

      ),
    );
  }

}