import 'package:brandstore/NavDrawer.dart';
import 'package:brandstore/pages/MyCartPage.dart';
import 'package:brandstore/pages/ProductDetailsPage.dart';
import 'package:brandstore/pages/ProductsList.dart';
import 'package:brandstore/pages/SignInPage.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MyHomePage extends StatefulWidget {


    final  username;

    MyHomePage({Key key, this.username }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime currentBackPressTime;

  final databaseReference = Firestore.instance;


  QuerySnapshot _querySnapshot;
  // QuerySnapshot _querySnapshot3;

  int len=0;

  bool ready=false;

QuerySnapshot onOfferSnapshot,onTrendSnapshot;

  Future queryData() async{
    return  Firestore.instance.collection("Homepage").document('SubHomepage').collection("onOffer").
    getDocuments().then((value) =>

        setState(() {
          onOfferSnapshot=value;
        }));
  }
  Future queryData2() async{
    return  Firestore.instance.collection("Homepage").document('SubHomepage').collection("onTrend").
    getDocuments().then((value) =>

        setState(() {
          onTrendSnapshot=value;
          ready=true;
        }));
  }
  @override
  void initState() {
    queryData();
    queryData2();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        drawer: NavDrawer(username: widget.username),
        appBar: AppBar(
         title: Text("Brandstore"),backgroundColor: Color(0xff0f4c81),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){
                Fluttertoast.showToast(msg: "Not implemented",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.teal,textColor: Colors.white);

               },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(mail: widget.username,)));
               },
            ),
            PopupMenuButton(
              //icon: Icon(Icons.settings),
              onSelected: (newValue) { // add this property
                 Fluttertoast.showToast(msg: newValue.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.teal,textColor: Colors.white);


              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("T&C"),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("FAQ"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Container(
                    width: 70,
                    child:Text("Rate Us")
                  ),
                  value: 2,
                ),

              ],
            )
          ],

        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: SingleChildScrollView(
            child: Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.all(7),
                child : Column(
                  children: <Widget>[
                    Swipperlayout(),
                    categorylist(widget.username,),
                    Container(
                      height: 40,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                        Expanded(child: Text("On Offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.white),),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferAndTrend(path: "onOffer",
                            mailx: widget.username,header: "OnOffer",) ));

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("More",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.white),),
                              Icon(Icons.navigate_next,color: Colors.white,size: 30,),
                            ],
                          ),
                        ),


                      ],),
                    ),
                   ready? listhorizontal("onOffer",widget.username,onOfferSnapshot):Container(),
                    Container(
                      height: 40,
                      child:  Row(children: <Widget>[
                        Expanded(child: Text("On Trend",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.white),),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferAndTrend(path: "onTrend",
                              mailx: widget.username,header: "OnTrend",) ));

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("More",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.white),),
                              Icon(Icons.navigate_next,color: Colors.white,size: 30,),
                            ],
                          ),
                        ),

                      ],),
                    ),
                   ready? listhorizontal("onTrend",widget.username,onTrendSnapshot):Container(),
                    Divider(height: 25,color: Colors.white,thickness: 2,endIndent: 20,indent: 20,),
                    Container(
                      child: Text("All Offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                          fontFamily: "Raleway",color: Colors.white),),
                    ),
                    offerlist()
                  ],
                )
            ),
          ) ,
        ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
  Future<bool> _onBackPressed() {
    return  showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Exit!",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700),),
            content: Text("Are you sure?",style: TextStyle(color: Colors.black87,fontSize: 17,fontFamily: "Raleway",fontWeight: FontWeight.w600),),
            actions: <Widget>[
              FlatButton( onPressed: (){
                Navigator.of(context).pop(false);
                },
                child: Text("No",style: TextStyle(color: Colors.green,fontSize: 17,fontFamily: "Raleway",fontWeight: FontWeight.w600),),),
              FlatButton(onPressed: (){
                Navigator.of(context).pop(true);
                 },child: Text("Yes",style: TextStyle(color: Colors.green,fontSize: 17,fontFamily: "Raleway",fontWeight: FontWeight.w600),),),
            ],
            elevation: 24.0,
            backgroundColor: Colors.white,
          );
        }
    ) ??
        false;
  }


}

class Swipperlayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      height: 180,
      child: DotPaginationSwiper(
        children: <Widget>[
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic1"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic2"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic3"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic4"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic4"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}

class listhorizontal extends StatelessWidget{
  String path1,usernamexx;
  QuerySnapshot snapshot;


  listhorizontal(String s ,String username,QuerySnapshot querySnapshot){
    this.path1 = s;
    this.usernamexx=username;

    this.snapshot=querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      height: 320,
     // margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: snapshot.documents.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            var userDocument = snapshot.documents[index];
            // picture1[index] = userDocument["pic1"];

            var price =  int.parse(userDocument["price"]);
            assert(price is int);
            var offer = int.parse(userDocument["offer"]);
            assert(offer is int);
            var finalprice = (price*offer)/100;
            var finalpricexx = price-finalprice;
            var finalpricexxx=  finalpricexx.round();

            return GestureDetector(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage( snapshot: snapshot.documents[index],
                  path1: "Homepage", path2: "SubHomepage",path3: path1,path4:index.toString(),mail: usernamexx,) ));
              },
              child: Container(
                height: 320,
                width: 176,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: new BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: 176,
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(userDocument["pic1"],

                          fit: BoxFit.cover,
                        ) ,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),

                      child:  Text(userDocument["name1"],maxLines: 1,style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,

                      ),
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.only(left: 5),

                    child: Text(userDocument["name2"],maxLines: 1,style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600 ,
                        fontFamily: "Raleway",
                        color: Colors.white
                    ),
                    ) ,
                  ),


                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,

                          ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(userDocument["price"],style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white,
                              decorationThickness: 2
                          ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(userDocument["offer"]+"%off",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,

                          ),
                          ),
                        ),




                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

class categorylist extends StatelessWidget{
  var mail;
  categorylist(String usernamex){
    mail=usernamex;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final list1 = ['tshirts','pants','shoes','watches','sunglass','bags/wa','sports'];

    return  Container(
      height: 70,
       margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: (){
                if (index==0){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:mail,
                    path1: "Category",path2: "SubCategory",path3: "TShirts",),),);
                }

              else if (index==1){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:mail,
                    path1: "Category",path2: "SubCategory",path3: "Pants",),),);
              }
                else if (index==2){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:mail,
                    path1: "Category",path2: "SubCategory",path3: "Shoes",),),);
                }
                else if (index==3){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:mail,
                    path1: "Category",path2: "SubCategory",path3: "Watches",),),);
                }
                else if (index==4){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:mail,
                    path1: "Category",path2: "SubCategory",path3: "Sunglasses",),),);
                }
                else {
                   Fluttertoast.showToast(msg: "Data not found",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.teal,textColor: Colors.white);
                }

              },
              child: Container(
                height: 60,
                width: 65,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: Firestore.instance.collection('Category').document('Icondata').collection("Icons").document("a"+index.toString()).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          var userDocument = snapshot.data;
                          // picture1[index] = userDocument["pic1"];
                          return   Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(top: 5),
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(userDocument["pic1"],

                                fit: BoxFit.cover,
                              ) ,
                            ),
                          );
                        }
                    ),

                    Text(list1[index],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

class offerlist extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      height: 139,
      // margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              height: 135,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: new BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("offerCards").document("a"+index.toString()).snapshots(),

                       builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        // picture1[index] = userDocument["pic1"];
                        return   Container(
                          height: 135,
                          width: 250,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(userDocument["pic1"],
                              fit: BoxFit.fitWidth,
                            ) ,
                          ),
                        );
                      }
                  ),



                ],
              ),
            );
          }
      ),
    );
  }

}

class OfferAndTrend extends StatelessWidget{

  final path,mailx,header;

  const OfferAndTrend({Key key, this.path, this.mailx,this.header}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(header),
      ),
      body: Container(
        color: Colors.black12,
        child: GridView.count(

          // crossAxisCount is the number of columns
          crossAxisCount: 2,
          //   childAspectRatio: (itemWidth / itemHeight),
          childAspectRatio: (100 / 180),
          // This creates two columns with two items in each column
          children: List.generate(8, (index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Homepage",
                  path2: "SubHomepage",path3: path,path4: index.toString(),mail: mailx,) ));


              },
              child: Container(
                  height: 200,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: new BorderRadius.circular(10)),

                  child:
                  Column(
                    children: <Widget>[
                      StreamBuilder(

                          stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            // picture1[index] = userDocument["pic1"];
                            return   Container(
                              height: MediaQuery.of(context).size.width*0.7,
                              width: MediaQuery.of(context).size.width*0.5,

                              child:  ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(userDocument["pic1"],

                                  fit: BoxFit.cover,
                                ) ,
                              ),
                            );
                          }
                      ),
                      StreamBuilder(
                          stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            // picture1[index] = userDocument["pic1"];
                            return     Container(
                              padding: EdgeInsets.only(left: 5),

                              child:  Text(userDocument["name1"],maxLines: 1,style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w700,
                                color: Colors.white,

                              ),
                              ),
                            );
                          }
                      ),
                      StreamBuilder(
                          stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            // picture1[index] = userDocument["pic1"];
                            return Container(
                              padding: EdgeInsets.only(left: 5),

                              child: Text(userDocument["name2"],maxLines: 1,style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600 ,
                                  fontFamily: "Raleway",
                                  color: Colors.white
                              ),
                              ) ,
                            );
                          }
                      ),
                      Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            StreamBuilder(
                                stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("Loading");
                                  }
                                  var userDocument = snapshot.data;
                                  // picture1[index] = userDocument["pic1"];

                                  var price =  int.parse(userDocument["price"]);
                                  assert(price is int);
                                  var offer = int.parse(userDocument["offer"]);
                                  assert(offer is int);
                                  var finalprice = (price*offer)/100;
                                  var finalpricexx = price-finalprice;
                                  var finalpricexxx=  finalpricexx.round();

                                  return   Container(
                                    //padding: EdgeInsets.only(left: 10),
                                    child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,

                                    ),
                                    ),
                                  );
                                }
                            ),
                            StreamBuilder(
                                stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("Loading");
                                  }
                                  var userDocument = snapshot.data;

                                  return     Container(
                                    //padding: EdgeInsets.only(left: 10),
                                    child: Text(userDocument["price"],style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.white,
                                        decorationThickness: 2
                                    ),
                                    ),
                                  );
                                }
                            ),

                            StreamBuilder(
                                stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).document("a"+index.toString()).snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("Loading");
                                  }
                                  var userDocument = snapshot.data;
                                  // picture1[index] = userDocument["pic1"];
                                  return   Container(

                                    //padding: EdgeInsets.only(left: 10),
                                    child: Text(userDocument["offer"]+"%off",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,

                                    ),
                                    ),
                                  );
                                }
                            ),



                          ],
                        ),
                      ),

                    ],
                  )


              ),

            );
          }
          ),
        ),
      )
    );
  }

}




