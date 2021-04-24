
import 'package:brandstore/pages/HomePage.dart';
import 'package:brandstore/pages/MyCartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brandstore/pages/CheckoutPage.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
 TextEditingController size=new TextEditingController();
TextEditingController qty=new TextEditingController();
final databaseReference = Firestore.instance;


class ProductDetailsPage extends StatefulWidget {

  final path1,path2,path3,path4,mail,snapshot;

  const ProductDetailsPage({Key key, this.path1, this.path2, this.path3, this.path4, this.mail,this.snapshot}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProgressDialog pr;

  String name1,name2,originalpricez,finalpricez,offer;


  @override
  Widget build(BuildContext context) {


    pr = new ProgressDialog(context);
    pr.style(
        message: 'Adding to Cart..', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    return Scaffold(

        appBar: AppBar(title: Text("Details"),backgroundColor: Color(0xff0f4c81),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen(mail: widget.mail,)));
              },
            ),
          ],),
        body:  SingleChildScrollView(
          child:  Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),

                  height: MediaQuery.of(context).size.height*0.55,
                  width: MediaQuery.of(context).size.height,
                  child: DotPaginationSwiper(
                    children: <Widget>[
                      Container(

                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.snapshot["pic1"],
                            loadingBuilder: (context,child,progress){
                              return progress == null ? child : CircularProgressIndicator();
                            },
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                      Container(

                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.snapshot["pic2"],
                            loadingBuilder: (context,child,progress){
                              return progress == null ? child : CircularProgressIndicator();
                            },
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                      Container(

                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.snapshot["pic3"],
                            loadingBuilder: (context,child,progress){
                              return progress == null ? child : CircularProgressIndicator();
                            },
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 2,left: 5,right: 5),
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: new BorderRadius.circular(10)),
                    child:
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 7,top: 4,bottom: 4),

                          child:  Text(widget.snapshot["name1"],maxLines: 1,style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,

                          ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 7),

                          child: Text(widget.snapshot["name2"],maxLines: 1,style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600 ,
                              fontFamily: "Roboto",
                              color: Colors.white
                          ),
                          ) ,
                        ),


                        Container(
                          width: MediaQuery.of(context).size.width-15,
                          height: 35,
                          child: ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                var products = widget.snapshot;

                                var price =  int.parse(products["price"]);
                                originalpricez=products["price"];
                                assert(price is int);
                                var offer = int.parse(products["offer"]);
                                assert(offer is int);
                                var finalprice = (price*offer)/100;
                                var finalpricexx = price-finalprice;
                                var finalpricexxx=  finalpricexx.round();

                                finalpricez=finalpricexxx.toString();
                                return   Row(

                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 5),

                                      child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700,
                                      ),
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(products["price"],style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",

                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.white,
                                          decorationThickness: 2
                                      ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      margin: EdgeInsets.only(right: 25),

                                      child: Text(products["offer"]+"%off",style: TextStyle(
                                        color: Colors.white,    fontFamily: "Roboto",

                                        fontWeight: FontWeight.w700,

                                      ),
                                      ),
                                    ),


                                    Icon(Icons.star,color: Colors.white,),
                                    Text("4.5",style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",

                                      fontWeight: FontWeight.w700,

                                    ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("50 Reviews",style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w700,

                                    ),
                                    ),

                                  ],
                                );
                              }
                          ),
                        ),

                      ],
                    )


                ),


                SizeQtyColorCard(),

                Center(
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    margin: EdgeInsets.only(top: 30.0, bottom: 15),
                    child: RaisedButton(
                      color:  Color(0xff0f4c81),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFFceced8))),
                      onPressed: () {
                        var qtyx=qty.text;
                        if(qtyx.isEmpty){
                          Fluttertoast.showToast(msg:"Select a quantity",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                        }
                        else if(widget.snapshot==null){
                          Fluttertoast.showToast(msg:"Rendering. wait",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                        }
                        else{
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) =>
                              CheckoutPage(snapshot: widget.snapshot,fprice: finalpricez,qty: qtyx,mail:widget.mail ,)));
                        }

                      },
                      child: Text('Buy Now', style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    margin: EdgeInsets.only(top: 15.0, bottom: 20),
                    child: RaisedButton(
                      color:  Color(0xff0f4c81),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFFceced8))),
                      onPressed: () async {
                        await pr.show();
                        pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
                        var qtyx=qty.text;
                        if(  qtyx.isEmpty){
                          Fluttertoast.showToast(msg: "Select qty",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);

                        }
                        else{
                          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                          String date = dateFormat.format(DateTime.now());
                         Firestore.instance.collection(widget.mail).document("Cartinfo").collection("Cartx").document().setData({
                            "path1":widget.path1,
                            "path2":widget.path2,
                            "path3":widget.path3,
                            "path4":widget.path4,
                            "qty":qtyx,
                            "date":date

                          });

                          Fluttertoast.showToast(msg: "Item Added successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                        }
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
                        await pr.hide();

                      },
                      child: Text('Add to Cart', style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                AboutThisItem(),

                //Horizonatal listciew.builder
                 //listhorizontal("bestSelling",widget.uid)
              ],
            ),
          ),
        )
    );
  }

}



class SizeQtyColorCard extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: new BorderRadius.circular(10)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 125,
            child: Column(

              children: <Widget>[
                Text("Quantity",style: TextStyle(fontSize: 18,color: Colors.white,
                    fontWeight: FontWeight.w700,fontFamily: "Roboto"),),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        qty.text="0";
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8,),

                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Icon(Icons.exposure_minus_1),
                      ),
                    ),
                    Container(
                      height:35,
                      width:40,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 15,bottom: 10,left: 10,right: 10),
                      alignment: Alignment.center,
                      child:   TextField(
                        controller: qty,
                        textAlign: TextAlign.center,
                        readOnly: true,

                        style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Roboto",fontSize: 20,color: Colors.black),
                        decoration: InputDecoration(border: InputBorder.none,),
                        //readOnly: true,
                      ),
                      // Text("S",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),
                    ),
                    GestureDetector(
                      onTap: (){
                        qty.text="1";
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8,),

                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Icon(Icons.plus_one),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 10),
            width: 125,
            child: Column(

              //size column
              children: <Widget>[
                Text("Delivery time",style: TextStyle(fontSize: 18,color: Colors.white,
                    fontWeight: FontWeight.w700,fontFamily: "Roboto"),),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(Icons.calendar_today_outlined,color: Colors.white,),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text("3days",style: TextStyle(fontSize: 18,color:Colors.white,
                          fontWeight: FontWeight.w700,fontFamily: "Roboto"),),
                    )
                  ],
                ),




              ],
            ),
          ),

        ],
      ),
    );
  }

}



class AboutThisItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200 ,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: new BorderRadius.circular(10)),

      child: Text("About this Item",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
    );
  }

}