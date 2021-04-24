
import 'package:brandstore/pages/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
TextEditingController address=new TextEditingController();
TextEditingController newaddress=new TextEditingController();

class CheckoutPage extends StatefulWidget{
  final  mail,qty,snapshot,fprice;

  CheckoutPage({Key key, this.mail,this.qty,this.snapshot,this.fprice}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}
class _CheckoutPageState extends State<CheckoutPage>{
  ProgressDialog pr;


  int group =0;
  int group2 =0;
  bool a=false,b=false;

  bool isok=false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Processing..', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    return Scaffold(
        appBar: AppBar(title: Text("Checkout"),backgroundColor: Color(0xff0f4c81),),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 8,top: 7,right: 8),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Select A Delivery A ddress",style: TextStyle(fontFamily: "Roboto",fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black87),),
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 1, groupValue: group, onChanged:(T){
                      a=true;
                      b=false;
                      // isok=false;
                      setState(() {
                        group=T;
                      });
                    },
                    ),
                    Text("Use Primary/Home Address",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 2, groupValue: group, onChanged:(T){
                      b=true;
                      a=false;
                      isok=true;
                      setState(() {
                        group=T;
                      });
                    },
                    ),
                    Text("Use A New Address",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),

                a ? StreamBuilder(
                    stream: Firestore.instance.collection(widget.mail).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      String addressx=userDocument["address1"];
                      // picture1[index] = userDocument["pic1"];

                      if(addressx.length!=0){
                        address.text=addressx;
                        isok=true;
                        return  Container(
                          height: 220,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border:Border.all(color: Colors.black54) ,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child:  TextField(
                            controller: address,
                            maxLines: 10,
                            readOnly: true,
                            maxLength: 300,
                            style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Roboto",fontSize: 18,color: Colors.black54),
                            decoration: InputDecoration(border: InputBorder.none,),
                            //readOnly: true,
                          ),
                        );
                      }
                      else{
                        Fluttertoast.showToast(msg: "Address not found",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.teal,textColor: Colors.white);

                        isok=false;
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border:Border.all(color: Colors.black54) ,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text("Address not Found"),
                        );
                      }

                    }
                ):Container(),
                b ? Container(
                  height: 220,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border:Border.all(color: Colors.black54) ,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child:  TextField(
                    controller: newaddress,
                    maxLines: 10,
                    readOnly: false,

                    maxLength: 300,
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Roboto",fontSize: 18,color: Colors.black54),
                    decoration: InputDecoration(border: InputBorder.none,hintText: "Give the address as accurate as possible",hintStyle:
                    TextStyle(color: Colors.black38)),
                    //readOnly: true,
                  ),
                ):Container(),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Select A Payment Type",style: TextStyle(fontFamily: "Roboto",fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 1, groupValue: group2, onChanged:(T){
                      setState(() {
                        group2=T;
                      });
                    },),
                    Text("UPI",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 2, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                    Text("Debit/Credit Card",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 3, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                    Text("Net Banking",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 4, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                    Text("Pay on Delivery",style: TextStyle(fontFamily: "Roboto",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                  ],
                ),
                Text("Note: We use Paytm payment Gateway for online payment services.",style: TextStyle(fontFamily: "Roboto",fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black87),),

                Container(
                  width: 300.0,
                  height: 50.0,
                  margin: EdgeInsets.only(top: 30.0, bottom: 15),
                  child: RaisedButton(
                    color: Color(0xff0f4c81),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFFceced8))),
                    onPressed: () async {

                      if(!a & !b){
                        Fluttertoast.showToast(msg: "Select an Address",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.teal,textColor: Colors.white);
                      }
                      else  if(group2==0){
                        Fluttertoast.showToast(msg: "Select a Payment",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.teal,textColor: Colors.white);
                      }
                      else if(!isok){
                        Fluttertoast.showToast(msg: "Give an Address",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.teal,textColor: Colors.white);
                      }
                      else if(group2==4){
                        if(a && address.text!=null && address.text.length>=10){
                          await pr.show();
                          pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
                          // Do something when payment succeeds
                          //  Fluttertoast.showToast(msg: "Paymet was successful", backgroundColor: Colors.deepPurpleAccent,textColor: Colors.white,toastLength: Toast.LENGTH_SHORT);


                          if( widget.qty.isEmpty  ){
                            Fluttertoast.showToast(msg:"Session expired",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);
                            await pr.hide();
                          }
                          else{


                            final getPersonalData =  await Firestore.instance.collection(widget.mail).document("PersonalInfo").get();

                            var personalData=getPersonalData.data;

                            var oid=DateTime.now().millisecondsSinceEpoch;
                            //DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                            await Firestore.instance.collection(widget.mail).document("Orderinfo").collection("Orderx").document().setData({
                              "pic1":widget.snapshot["pic1"],
                              "pic2":widget.snapshot["pic2"],
                              "pic3":widget.snapshot["pic3"],
                              "name1":widget.snapshot["name1"],
                              "name2":widget.snapshot["name2"],
                              "oprice":widget.snapshot["price"],
                              "fprice":widget.fprice,
                              "offer":widget.snapshot["offer"],
                              "qty":widget.qty,
                              "address":newaddress.text,
                              "orderid":"ORDER_"+oid.toString(),
                              "paymentid":"",
                              "date": date,
                              "status":false,

                            });

                            await Firestore.instance.collection("Orders").document().setData({
                              "pic1":widget.snapshot["pic1"],
                              "pic2":widget.snapshot["pic2"],
                              "pic3":widget.snapshot["pic3"],
                              "name1":widget.snapshot["name1"],
                              "name2":widget.snapshot["name2"],
                              "oprice":widget.snapshot["price"],
                              "fprice":widget.fprice,
                              "offer":widget.snapshot["offer"],
                              "qty":widget.qty,
                              "address":newaddress.text,
                              "orderid":"ORDER_"+oid.toString(),
                              "paymentid":"",
                              "date": date,
                              "status":false,


                            });

                            await pr.hide();

                            Fluttertoast.showToast(msg:"Order placed Sucessfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);

                            Navigator.of(context).pop();
                          }
                        }
                        else if(b && newaddress.text!=null && newaddress.text.length>=10){
                          await pr.show();
                          pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
                          // Do something when payment succeeds
                          //  Fluttertoast.showToast(msg: "Paymet was successful", backgroundColor: Colors.deepPurpleAccent,textColor: Colors.white,toastLength: Toast.LENGTH_SHORT);


                          if( widget.qty.isEmpty  ){
                            Fluttertoast.showToast(msg:"Session expired",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);
                            await pr.hide();
                          }
                          else{


                            final getPersonalData =  await Firestore.instance.collection(widget.mail).document("PersonalInfo").get();

                            var personalData=getPersonalData.data;

                            var oid=DateTime.now().millisecondsSinceEpoch;
                            //DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                            await Firestore.instance.collection(widget.mail).document("Orderinfo").collection("Orderx").document().setData({
                              "pic1":widget.snapshot["pic1"],
                              "pic2":widget.snapshot["pic2"],
                              "pic3":widget.snapshot["pic3"],
                              "name1":widget.snapshot["name1"],
                              "name2":widget.snapshot["name2"],
                              "oprice":widget.snapshot["price"],
                              "fprice":widget.fprice,
                              "offer":widget.snapshot["offer"],
                              "qty":widget.qty,
                              "address":newaddress.text,
                               "orderid":"ORDER_"+oid.toString(),
                              "paymentid":"",
                              "date": date,
                              "status":false,

                            });

                            await Firestore.instance.collection("Orders").document().setData({
                              "pic1":widget.snapshot["pic1"],
                              "pic2":widget.snapshot["pic2"],
                              "pic3":widget.snapshot["pic3"],
                              "name1":widget.snapshot["name1"],
                              "name2":widget.snapshot["name2"],
                              "oprice":widget.snapshot["price"],
                              "fprice":widget.fprice,
                              "offer":widget.snapshot["offer"],
                              "qty":widget.qty,
                              "address":newaddress.text,
                              "orderid":"ORDER_"+oid.toString(),
                              "paymentid":"",
                              "date": date,
                              "status":false,

                            });


                            await pr.hide();

                            Fluttertoast.showToast(msg:"Order placed Sucessfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);

                            Navigator.of(context).pop();
                          }
                        }
                        else{
                          Fluttertoast.showToast(msg: "Address is empty",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
                        }


                      }
                      else {
                        //openCheckout();

                        if(a && address.text!=null && address.text.length>=10){
                          final snapShot =  await Firestore.instance.collection(widget.mail).document("PersonalInfo").get();

                          if (snapShot.exists) {
                            var userDocument = snapShot.data;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(amount: widget.fprice.toString(),
                              mail: userDocument["email"],phone: userDocument["phone"],qty: widget.qty,snapshot: widget.snapshot,address: address.text,)));
                          }
                        }
                        else if(b && newaddress.text!=null && newaddress.text.length>=10){
                          final snapShot =  await Firestore.instance.collection(widget.mail).document("PersonalInfo").get();
                          if (snapShot.exists) {
                            var userDocument = snapShot.data;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(amount: widget.fprice.toString(),
                              mail: userDocument["email"],phone: userDocument["phone"],qty: widget.qty,snapshot: widget.snapshot,address: newaddress.text,)));
                          }
                        }
                        else{
                          Fluttertoast.showToast(msg: "Address is empty",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
                        }


                      }
                    },
                    child: Text( group2==4? "Place order":'Proceed to pay', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
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




