
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddressPage extends StatelessWidget{

  String username = "";

  AddressPage({Key key, this.username}) : super(key: key);

  TextEditingController address1=new TextEditingController();
  TextEditingController address2=new TextEditingController();

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //  implement buildj
    return Scaffold(
      appBar: AppBar( title: Text("Address"),backgroundColor: Color(0xff0f4c81)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 6,top: 8),
                alignment: Alignment.topLeft,
                child: Text("Home:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
              ),

              StreamBuilder(
                  stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocument = snapshot.data;
                    address1.text=userDocument["address1"];
                    // picture1[index] = userDocument["pic1"];
                    return  Container(
                      height: 200,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,

                      ),
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.only(left: 6,right: 6,bottom: 6),

                      child:  TextField(
                        controller: address1,
                        maxLines: 8,
                        maxLength: 500,

                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                        decoration: InputDecoration(border: InputBorder.none,),
                        //readOnly: true,
                      ),
                    );



                  }
              ),
              Container(
                padding: EdgeInsets.only(left: 6,top: 8),
                alignment: Alignment.topLeft,
                child: Text("Office:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
              ),

              StreamBuilder(
                  stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocument = snapshot.data;
                    address2.text=userDocument["address2"];
                    // picture1[index] = userDocument["pic1"];
                    return  Container(
                      height: 200,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,

                      ),
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.only(left: 6,right: 6,bottom: 6),

                      child:  TextField(
                        controller: address2,
                        maxLines: 8,
                        maxLength: 500,

                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                        decoration: InputDecoration(border: InputBorder.none,),
                        //readOnly: true,
                      ),
                    );

                  }
              ),


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

                    databaseReference.collection(username).document('PersonalInfo').updateData({
                      "address1":address1.text,
                      "address2":address2.text,


                    });
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
      ),
    );
  }

}