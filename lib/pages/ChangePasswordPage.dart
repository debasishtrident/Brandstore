import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ChangPass extends StatelessWidget{


  String username = "";

  ChangPass({Key key, this.username}) : super(key: key);

  TextEditingController currentPass=new TextEditingController();
  TextEditingController newPass=new TextEditingController();
  TextEditingController confirmPass=new TextEditingController();


  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
        appBar: AppBar( title: Text("Change pwd"),backgroundColor: Color(0xff0f4c81)),
         body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Current Password:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
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
                    controller: currentPass,

                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none,),
                    //readOnly: true,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("New Password:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
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
                    controller: newPass,
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none),

                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Confirm Password:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
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
                    controller: confirmPass,
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none),

                  ),
                ),
                Text("Note: If you forgot your current password, You\n can logout and reset it from login page",
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

                      Fluttertoast.showToast(msg: "Updated successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.teal,textColor: Colors.white);



                    },
                    child: Text('Update', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}