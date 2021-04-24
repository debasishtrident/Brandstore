
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class OrderDetailsPage extends StatelessWidget{

  final uid,snapshot;

  OrderDetailsPage({Key key, this.uid,this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var a= snapshot["fprice"];
    double b=double.parse(a);
    double c=b-5.0;
    // TODO: implement buildj
    return Scaffold(
        appBar: AppBar(title: Text("Order Details") ,backgroundColor: Color(0xff0f4c81)
          ,),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Order Details",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  height: 130,
                  width: 330,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(

                    border: Border.all(color: Colors.teal),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 35,
                        child: Text("Date:"+snapshot["date"],style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),

                      ),
                      Container(
                        height: 35,
                        child: Text("PID:"+snapshot["paymentid"],style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 13,color: Colors.white),),
                      ),
                      Container(
                        height: 35,
                        child: Text("OID:"+snapshot["orderid"].toString(),style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),


                      ),



                    ],
                  ),
                ),
                // orderdetails(uid,indexno),

                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Shipment Details ",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  height: 250,
                  width: 330,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    //         gradient: LinearGradient(
//          begin: Alignment.topLeft,
//          end: Alignment.bottomRight,
//          colors: [
//            Colors.black38,
//            Colors.white,
//            Colors.black26
//          ]
//        ),
                      border: Border.all(color: Colors.teal)
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 7,top: 5),

                        alignment: Alignment.topLeft,
                        child:  Text("Shipped:",
                          style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w700, ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 7,top: 5,bottom: 10),
                        alignment: Alignment.topLeft,

                        child:  Text(snapshot["date"],
                          style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w700 ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.teal,
                      ),
                      Container(
                        margin: EdgeInsets.all( 1),
                        color: Colors.black,
                        height: 110.0,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(

                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(snapshot["pic1"],width: 100,height: 100,
                                loadingBuilder: (context,child,progress){
                                  return progress == null ? child : CircularProgressIndicator();
                                },),
                            ),

                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 200,
                                  margin: EdgeInsets.only( top: 8),
                                  child: Text(snapshot["name1"],
                                    style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 220,
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text("₹"+snapshot["fprice"],
                                    style: TextStyle(fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,

                                  height: 25,
                                  width: 200,
                                  margin:
                                  EdgeInsets.only(top: 8),
                                  child: Text("Sold: Clean Fresh",
                                    style: TextStyle(fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 7,top: 5, ),
                        alignment: Alignment.topLeft,

                        child:  Text("Color: Default",
                          style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w700, ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 7,top: 5 ),
                        alignment: Alignment.topLeft,

                        child:  Text("QTY:"+snapshot["qty"],
                          style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w700,  ),
                        ),
                      ),

                    ],
                  ),
                ),
                // ShipmentDetails(uid,indexno),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Shipment Address",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  height: 180,
                  width: 330,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(

                      border: Border.all(color: Colors.teal)
                  ),
                  child: Text(snapshot["address"],maxLines: 10,style: TextStyle(fontFamily: "Raleway",fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                // ShipmentAddress(uid ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Order Summary",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  height: 200,
                  width: 330,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal)
                  ),
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Items:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text(c.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Postage and Packaging:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text("+05",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tax:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text("--",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Total:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text("+"+a.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Promotion:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text("+00",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Delivery charge:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                          Text("+00",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Grand Total:",style: TextStyle(fontSize: 18,fontFamily: "Raleway",fontWeight: FontWeight.w600 ),),
                          Text("+"+a.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway",fontWeight: FontWeight.w600 )),
                        ],
                      ),
                    ],
                  ),
                ),
                // OrderSummary(uid,indexno),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Reward on this order",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  width: 330,
                  height: 30,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal,)
                  ),
                  padding: EdgeInsets.only(left: 5, ),
                  child: Text("20 points",style: TextStyle(fontFamily: "Roboto" ,fontSize: 18 ),),
                ),
              ],
            ),
          ),
        )
    );
  }

}



