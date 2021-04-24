

import 'package:brandstore/pages/HomePage.dart';
import 'package:brandstore/pages/OrderDetailsPage.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_dialog/rating_dialog.dart';


import '../main.dart';
var length=0;

class MyOrdersPage extends StatefulWidget{
  final username;
  MyOrdersPage({Key key, this.username}) ;

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {

  QuerySnapshot _querySnapshot;
  @override
  void initState() {

    queryData();

  }
  bool ready=false;

  Future queryData() async {
    return  Firestore.instance.collection(widget.username).
    document("Orderinfo").collection("Orderx").orderBy("date",descending: true).getDocuments().then((value) =>
        setState(() {
          _querySnapshot=value;
          ready=true;
        }));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color baseColor = Color(0xFFF2F2F2);

    AssetImage assetImage = AssetImage("assets/images/emptyorder.png");
    Image image = Image(
      image: assetImage,
    );
    return Scaffold(
        appBar: AppBar(title: Text("Orders"),backgroundColor: Color(0xff0f4c81)),

        //  appBar: AppBar(title: Text("Orders") ,backgroundColor: Color(0xff0f4c81),),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(

              children: <Widget>[
                ready? Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(7),
                  child: Text(
                    "You have " + _querySnapshot.documents.length.toString() + " orders in your List", maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ):Center(
                  child: Container(
                    child: Text("Loading"),
                  ),
                ),
                ready && _querySnapshot.documents.length==0?   Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      child: image,
                    ),

                    Text("OOPS \nNo orders found",textAlign: TextAlign.center,style: TextStyle(
                      fontFamily: "Roboto",fontSize: 15,fontWeight: FontWeight.w600,
                    ),),

                    Container(
                      width: 300.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 30.0, bottom: 15),
                      child: RaisedButton(
                        color: Color(0xff0f4c81),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15),
                            side: BorderSide(color: Color(0xFFceced8))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(username: widget.username,)));
                        },
                        child: Text('Continue shopping', style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ):ready?
                Container(
                  alignment: Alignment.topLeft,

                  //height: 320,
                  margin: EdgeInsets.all(6),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _querySnapshot.documents.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {

                        var data=_querySnapshot.documents[index];
                         return Container(

                          margin: EdgeInsets.all(5),
                          child: ClayContainer(
                            height: 120.0,
                            borderRadius: 10,
                            color: baseColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                        OrderDetailsPage(uid: widget.username,snapshot: _querySnapshot.documents[index],)));
                                  },
                                  child: Container(
                                    height: 120.0,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              data["pic1"],
                                              loadingBuilder: (context,child,progress){
                                                return progress == null ? child : CircularProgressIndicator();
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10,right: 10),

                                              alignment: Alignment.center,
                                              //width: MediaQuery.of(context).size.width-120,
                                              margin: EdgeInsets.only( top: 8),
                                              child: Text(data["name1"],
                                                style: TextStyle(fontFamily: "Roboto", fontSize: 18,
                                                    fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                            ),Container(
                                              padding: EdgeInsets.only(left: 10,right: 10),

                                              alignment: Alignment.center,
                                              //width: MediaQuery.of(context).size.width-120,

                                              // margin: EdgeInsets.only(top: 8),
                                              child: Text("Status : Not delivered yet",
                                                style: TextStyle(fontFamily: "Roboto", fontSize: 16,
                                                    fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                            ),



                                            Container(
                                              padding: EdgeInsets.only(left: 10,right: 10),


                                              alignment: Alignment.center,
                                              //   width: MediaQuery.of(context).size.width-120,
                                              //margin: EdgeInsets.only(top: 8),
                                              child: Text("OID:"+data["orderid"].toString(),
                                                style: TextStyle(fontFamily: "Roboto", fontSize: 14,
                                                    fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                             // width: MediaQuery.of(context).size.width-120,
                                              padding: EdgeInsets.only(left: 15,right: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(

                                                    height: 30,
                                                    margin: EdgeInsets.only(top: 10),
                                                    alignment: Alignment.bottomRight,
                                                    child: RaisedButton(
                                                      color:  Color(0xff0f4c81) ,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: new BorderRadius.circular(15),
                                                          side: BorderSide(color: Color(0xFFceced8))),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible: true, // set to false if you want to force a rating
                                                            builder: (context) {
                                                              return RatingDialog(
                                                                icon: Image.network(data["pic1"],height: 170,), // set your own image/icon widget
                                                                title: "Item ID:s23",
                                                                description:
                                                                "Tap a star to set your rating.\nNote: Review/Rating can't be Edited later",
                                                                submitButton: "SUBMIT",
                                                                alternativeButton: "Contact us instead?", // optional
                                                                positiveComment: "We are so happy to hear :)", // optional
                                                                negativeComment: "We're sad to hear :(", // optional
                                                                accentColor: Colors.red, // optional
                                                                onSubmitPressed: (int rating) {
                                                                  print("onSubmitPressed:"+"Rated"+rating.toString()+"Star");
                                                                  //   open the app's page on Google Play / Apple App Store
                                                                  Fluttertoast.showToast(textColor:Colors.white,backgroundColor: Colors.deepPurpleAccent,
                                                                      msg: "Review noted successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                                                },
                                                                onAlternativePressed: () {
                                                                  print("onAlternativePressed: do something"+"Rated"+"3 or less Star");
                                                                  //  maybe you want the user to contact you instead of rating a bad review
                                                                  //Fluttertoast.showToast(textColor:Colors.white,backgroundColor: Colors.deepPurpleAccent,
                                                                  // msg: "Help not found",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                                                  //Navigator.of(context).pop();
                                                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactUsPage()));
                                                                },
                                                              );
                                                            });

                                                        //  Fluttertoast.showToast(msg: "Fature not present",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);


                                                      },
                                                      child: Text("Review", style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Roboto",
                                                          fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      }),
                ):Center(
                  child: Container(
                    child: Text("Loading"),
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }
}
