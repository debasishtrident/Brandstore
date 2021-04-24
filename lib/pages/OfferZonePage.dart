
import 'package:brandstore/pages/ProductDetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class OfferZonePage extends StatefulWidget{

  final mailx;

  const OfferZonePage({Key key,this.mailx}) : super(key: key);

  @override
  _OfferZonePageState createState() => _OfferZonePageState();
}

class _OfferZonePageState extends State<OfferZonePage> {
  QuerySnapshot _querySnapshot;
  // QuerySnapshot _querySnapshot3;

  int len=0;

  bool ready=false;

  QuerySnapshot onOfferSnapshot;

  Future queryData() async{
    return  Firestore.instance.collection("Homepage").document('SubHomepage').collection("onOffer").
    getDocuments().then((value) =>

        setState(() {
          onOfferSnapshot=value;
          ready=true;
        }));
  }
  @override
  void initState() {
    queryData();
   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar( title: Text("Offer Zone"),backgroundColor: Color(0xff0f4c81)),

      body: Container(
        color: Colors.black12,
        child: GridView.count(
          // crossAxisCount is the number of columns
          crossAxisCount: 2,
          //   childAspectRatio: (itemWidth / itemHeight),
          childAspectRatio: (100 / 180),
          // This creates two columns with two items in each column
          children: List.generate(8, (index) {
            var userDocument = onOfferSnapshot.documents[index];
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Homepage",
                  path2: "SubHomepage",path3: "onOffer",path4: index.toString(),mail: widget.mailx,snapshot: userDocument,) ));
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
                      Container(
                        height: MediaQuery.of(context).size.width*0.7,
                        width: MediaQuery.of(context).size.width*0.5,

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

                      Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(left: 10),
                              child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,

                              ),
                              ),
                            ),
                            Container(
                              //padding: EdgeInsets.only(left: 10),
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

                              //padding: EdgeInsets.only(left: 10),
                              child: Text(userDocument["offer"]+"%off",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,

                              ),
                              ),
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

