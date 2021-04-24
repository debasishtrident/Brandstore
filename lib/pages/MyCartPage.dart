
import 'package:brandstore/pages/HomePage.dart';
import 'package:brandstore/pages/PaymentCartScreen.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:progress_dialog/progress_dialog.dart';
var path1,path2,path3,path4;

class CartScreen extends StatefulWidget {
  final mail;

  CartScreen({Key key, this.mail})  ;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  QuerySnapshot _querySnapshot;
  // QuerySnapshot _querySnapshot3;

  int len=0;

  bool ready=false;



  Future queryData2() async{
    return  Firestore.instance.collection(widget.mail).document("Cartinfo").collection("Cartx").
    getDocuments().then((value) =>

        setState(() {
          _querySnapshot=value;
          ready=true;

        }));
  }

  @override
  void initState() {
    queryData2();
  }

  ProgressDialog pr;

  int total=0;
  bool isready=false;
  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    AssetImage assetImage = AssetImage("assets/images/emptyorder.png");
    Image image = Image(
      image: assetImage,
    );
    return Scaffold(
      appBar: AppBar(

        title: Text("Cart"),backgroundColor: Color(0xff0f4c81),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ready? Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(7),
                child: Text(
                  "You have " + _querySnapshot.documents.length.toString() + " items in your Cart", maxLines: 1,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ):Container(),
              ready &&  _querySnapshot.documents.length==0 ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: image,
                  ),
                  Text("OOPS \nLooks like your cart is empty",textAlign: TextAlign.center,style: TextStyle(
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(username: widget.mail,)));
                      },
                      child: Text('Continue shopping', style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ):
              ready? Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      //height: 320,
                      margin: EdgeInsets.all(6),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ready?_querySnapshot.documents.length:0,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var daata=_querySnapshot.documents[index];
                            return StreamBuilder(
                                stream:  Firestore.instance.collection(daata["path1"]).document(daata["path2"]).
                                collection(daata["path3"]).snapshots(),
                                builder: (context, snapshot) {
                                  if(!snapshot.hasData){
                                    return Text("Loading");
                                  }

                                  var productss = snapshot.data.documents[int.parse(daata["path4"])];
                                  var price = int.parse(productss["price"]);
                                  assert(price is int);
                                  var offer = int.parse(productss["offer"]);
                                  var finalprice = (price * offer) / 100;
                                  var finalpricexx = price - finalprice;
                                  var finalpricexxx = finalpricexx.round();
                                  total=total+finalpricexxx;
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: ClayContainer(

                                      color: baseColor,
                                      height: 120.0,
                                      borderRadius: 10,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                productss["pic1"],
                                                loadingBuilder: (context,child,progress){
                                                  return progress == null ? child : CircularProgressIndicator();
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width: 200,
                                                margin: EdgeInsets.only(left: 8, top: 4),
                                                child: Text(
                                                  productss["name1"],
                                                  style: TextStyle(fontFamily: "Roboto", fontSize: 18,
                                                      fontWeight: FontWeight.w700, color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                margin: EdgeInsets.only(left: 8,  ),
                                                child: Text(
                                                  productss["name2"],
                                                  style: TextStyle(fontFamily: "Roboto", fontSize: 15,
                                                      fontWeight: FontWeight.w700, color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                margin: EdgeInsets.only(left: 8, ),
                                                child: Text("Q: " +daata["qty"],
                                                  style: TextStyle(fontFamily: "Roboto", fontSize: 15,
                                                      fontWeight: FontWeight.w700, color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    height: 25,
                                                    width: 100,
                                                    margin: EdgeInsets.only(left: 8,),
                                                    child: Text(
                                                      "₹"+ finalpricexxx.toString(),
                                                      style: TextStyle(fontFamily: "Roboto", fontSize: 18,
                                                          fontWeight: FontWeight.w700, color: Colors.black),
                                                    ),
                                                  ),
                                                  ClayContainer(
                                                    color: baseColor,
                                                    width: 100,
                                                    height: 35,
                                                    borderRadius: 10,
                                                    child: Container(
                                                      width: 100,
                                                      height: 35,
                                                      child: RaisedButton(

                                                        onPressed: () async {
                                                          var len;

                                                          await Firestore.instance.runTransaction((Transaction myTransaction) async {
                                                            await myTransaction.delete(daata.reference);

                                                          });


                                                          setState(() {
                                                            isready=false;
                                                            queryData2();
                                                          });
                                                          Fluttertoast.showToast(msg: "Item Removed",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);

                                                        },
                                                        child: Text('Remove',
                                                          style: TextStyle(color: Colors.white, fontFamily: "Roboto",fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );



                          }),
                    ),
                    Container(
                      width: 300.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 30.0, bottom: 15),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Color(0xff0f4c81),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15),
                            side: BorderSide(color: Color(0xFFceced8))),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          //Pricecal(totalx: total,);
                          if(!isready){
                            setState(() {
                              isready=true;

                              //total=0;
                            });
                          }

                          else{
                            Fluttertoast.showToast(msg: "Already in updated state",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                          }


                        },
                        child: Text('Calculate  total', style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    isready ? Pricecal(totalx: total,uid: widget.mail,length: _querySnapshot.documents.length,) :Container(),

                    // isready ? CheckoutCard(total) :Container(),

                  ],
                ),
              ):Container()


            ],
          ),
        ),
      ),
      // bottomNavigationBar: CheckoutCard(total),
    );
  }

}

class Pricecal extends StatelessWidget{

  final totalx,uid,length;

  const Pricecal({Key key, this.totalx,this.uid,this.length}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black38,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7),
            alignment: Alignment.topLeft,
            child: Text("Billing Details",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Price: " + length.toString()+ " items",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text("+"+totalx.toString(),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Delivery charge ",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text("+00",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Packaging charge ",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text("+00",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Grand Total ",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
              padding: EdgeInsets.all(7),
                child: Text(totalx.toString(),
                style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600),
                ),
                )

            ],
          ),
              Container(
              width: 300.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 30.0, bottom: 15),
              child: RaisedButton(
              color: Color(0xff0f4c81),
              shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15),
              side: BorderSide(color: Colors.white)),
              onPressed: () async {
          //                Fluttertoast.showToast(msg:"Payment gateway is not implemented",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
          //                    backgroundColor: Colors.teal,textColor: Colors.white);
              final snapShot =  await  Firestore.instance.collection(uid).document("PersonalInfo").get();

              if (snapShot.exists) {
              var userDocument = snapShot.data;
              if(userDocument["address1"]!="" || userDocument["address2"]!=""){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentCartScreen(
              amount: totalx,
              mail: userDocument["email"],phone: userDocument["phone"],totalItemsInCart: length,)));
              }
              else {
              Fluttertoast.showToast(msg:"Address not found",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.teal,textColor: Colors.white);
              }
              }
              },
              child: Text('Proceed to pay',
              style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600),
              ),
              ),
              ),

        ],
      ),
    );

  }

}