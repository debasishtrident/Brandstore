
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


TextEditingController mail=new TextEditingController();

class PassReset extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
      appBar: AppBar( title: Text("Reset"),backgroundColor: Color(0xff0f4c81)),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 6,top: 8),
              alignment: Alignment.topLeft,
              child: Text("Registered Gmail:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
            ),

            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,

              ),
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.only(left: 6),

              child:  TextField(
                controller: mail,

                style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                decoration: InputDecoration(border: InputBorder.none,),
                //readOnly: true,
              ),
            ),




            Text("Note: A Gmail will be send to your Registered GMail",
              textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: "Raleway",fontWeight: FontWeight.w600,color: Colors.black),),

            Container(
              width: 300.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 30.0, bottom: 15),
              child: RaisedButton(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15),
                    side: BorderSide(color: Color(0xFFceced8))),
                onPressed: () {
                  try{
                    if(mail.text!=""){
                      FirebaseAuth.instance.sendPasswordResetEmail(email: mail.text.trim());
                      Fluttertoast.showToast(msg: "Gmail sent successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.teal,textColor: Colors.white);

                    }
                  }catch(e)
                  {
                    Fluttertoast.showToast(msg:e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.teal,textColor: Colors.white);

                  }

                },
                child: Text('Send', style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}