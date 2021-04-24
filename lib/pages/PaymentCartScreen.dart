import 'dart:convert';

import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brandstore/Constants.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentCartScreen extends StatefulWidget {

  final  amount,mail,phone,totalItemsInCart;

  PaymentCartScreen({@required this.amount,@required this.mail,@required this.phone,
    @required this.totalItemsInCart,});

  @override
  _PaymentCartScreenState createState() => _PaymentCartScreenState();
}

class _PaymentCartScreenState extends State<PaymentCartScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;
  var paytmResponse;

  QuerySnapshot _querySnapshot;

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$PAYMENT_URL'><input type='hidden' name='orderID' value='ORDER_${DateTime.now().millisecondsSinceEpoch}'/>" +
        "<input  type='hidden' name='custID' value='${widget.mail}' />" +
        "<input  type='hidden' name='amount' value='${widget.amount}' />" +
        "<input type='hidden' name='custEmail' value='${widget.mail}' />" +
        "<input type='hidden' name='custPhone' value='${widget.phone}' />" +
        "</form> </body> </html>";
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) async {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final checksumResult = responseJSON["status"];
      paytmResponse = responseJSON["data"];


      if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
        if (checksumResult==0) {

          this.setState((){
            _responseStatus = STATUS_SUCCESSFUL;

          });
          //save cart info to order and clear the cart

          await prx.show();

          final getPersonalData =  await  Firestore.instance.collection(widget.mail).document("PersonalInfo").get();

          var personalData=getPersonalData.data;

          for(int i=0;i<widget.totalItemsInCart;i++){
            var doc=_querySnapshot.documents[i];
            var ok;
            final getPersonalDatas =  await  Firestore.instance.collection(doc["path1"]).document(doc["path2"]).
            collection(doc["path3"]).getDocuments();

            var personalDatasss=getPersonalDatas.documents[int.parse(doc["path4"])];

            var price = int.parse(personalDatasss["price"]);
            assert(price is int);
            var offer = int.parse(personalDatasss["offer"]);
            var finalprice = (price * offer) / 100;
            var finalpricexx = price - finalprice;
            var finalpricexxx = finalpricexx.round();

            await  Firestore.instance.collection(widget.mail).document("Orderinfo").collection("Orderx").document().setData({
              "pic1":personalDatasss["pic1"],
              "pic2":personalDatasss["pic2"],
              "pic3":personalDatasss["pic3"],
              "name1":personalDatasss["name1"],
              "name2":personalDatasss["name2"],
              "oprice":price.toString(),
              "fprice":finalpricexxx.toString(),
              "offer":personalDatasss["offer"],
              "qty":doc["qty"],
              "address":personalData["address1"]!=""?personalData["address1"]:personalData["address2"],

               "orderid":paytmResponse["ORDERID"],
              "paymentid":paytmResponse["TXNID"],
              "date": paytmResponse["TXNDATE"],
              "status":false,



            });

            await  Firestore.instance.collection("Orders").document().setData({
              "pic1":personalDatasss["pic1"],
              "pic2":personalDatasss["pic2"],
              "pic3":personalDatasss["pic3"],
              "name1":personalDatasss["name1"],
              "name2":personalDatasss["name2"],
              "oprice":price.toString(),
              "fprice":finalpricexxx.toString(),
              "offer":personalDatasss["offer"],
              "qty":doc["qty"],
              "address":personalData["address1"]!=""?personalData["address1"]:personalData["address2"],

              "orderid":paytmResponse["ORDERID"],
              "paymentid":paytmResponse["TXNID"],
              "date": paytmResponse["TXNDATE"],
              "status":false,

            });

            Fluttertoast.showToast(msg:"Order placed Sucessfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);

            await prx.hide();

          //DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");

        }
        }
        else {
          this.setState((){
            _responseStatus = STATUS_CHECKSUM_FAILED;
          });

        }
      } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
        this.setState((){
          _responseStatus = STATUS_FAILED;
        });

      }

    });
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        return PaymentSuccessfulScreen(paytmResponse);
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen(paytmResponse);
    }
    return PaymentSuccessfulScreen(paytmResponse);
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }


  Future queryData2() async{
    return  Firestore.instance.collection(widget.mail).document("Cartinfo").collection("Cartx").
    getDocuments().then((value) =>

        setState(() {
          _querySnapshot=value;
        }));
  }

  @override
  void initState() {
    queryData2();
  }
ProgressDialog prx;

  @override
  Widget build(BuildContext context) {
    prx = new ProgressDialog(context);
    prx.style(
        message: 'Processing..', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  debuggingEnabled: false,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller){
                    _webController = controller;
                    _webController
                        .loadUrl(new Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString());
                  },
                  onPageFinished: (page){
                    if (page.contains("/process")) {
                      if (_loadingPayment) {
                        this.setState(() {
                          _loadingPayment = false;
                        });
                      }
                    }
                    if (page.contains("/paymentReceipt")) {
                      getData();
                    }
                  },
                ),
              ),
              (_loadingPayment)
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Center(),
              (_responseStatus != STATUS_LOADING) ? Center(child:getResponseScreen()) : Center()
            ],
          )
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentSuccessfulScreen extends StatelessWidget {
  var paytmResponse;

  PaymentSuccessfulScreen(var paytmResponse){
    this.paytmResponse=paytmResponse;
    // this.amount=amount;
    // this.mail=mail;
    // this.phone=phone;
    // this.uid=uid;
    // this.qty=qty;
    // this.snapshot=snapshot;
  }

  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    return  Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,

      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset("images/success.png")
            ),
            SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Payment Successful!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,decoration:TextDecoration.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(paytmResponse["CURRENCY"]+": "+paytmResponse["TXNAMOUNT"],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,decoration:TextDecoration.none),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(paytmResponse["ORDERID"],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18,decoration:TextDecoration.none),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Text("Thank you for making the payment!",textAlign: TextAlign.center,

              style: TextStyle(fontSize: 20,decoration:TextDecoration.none,fontWeight: FontWeight.w600,  color: Color(0xff0f4c81),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ClayContainer(
              color: baseColor,

              child: MaterialButton(
                  child: Text(
                    "Close",
                    style: TextStyle(fontWeight:FontWeight.bold,color: Color(0xff0f4c81),),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );

  }
}

class PaymentFailedScreen extends StatelessWidget {
  var paytmResponse;

  PaymentFailedScreen(var paytmResponse){
    this.paytmResponse=paytmResponse;
  }
  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    return  SingleChildScrollView(

      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Image.asset("images/failed.png")
                ),
                SizedBox(height: 35,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Payment Failed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,decoration:TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(paytmResponse["RESPCODE"]+": "+paytmResponse["RESPMSG"]
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15,decoration:TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(paytmResponse["CURRENCY"]+": "+paytmResponse["TXNAMOUNT"],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,decoration:TextDecoration.none),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(paytmResponse["ORDERID"],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18,decoration:TextDecoration.none),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text("Couldn't complete your payment.\nTry Again ",textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 20,decoration:TextDecoration.none,fontWeight: FontWeight.w600,  color: Color(0xff0f4c81),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ClayContainer(
                  color: baseColor,

                  child: MaterialButton(
                      child: Text(
                        "Close",
                        style: TextStyle(fontWeight:FontWeight.bold,color: Color(0xff0f4c81),),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.lightBlue,
                  ),
                  child: Icon(Icons.close,color: Colors.white,size: 55,),
                ),
                SizedBox(height: 35,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Oh Snap!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,decoration:TextDecoration.none,  color: Colors.lightBlue,),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
