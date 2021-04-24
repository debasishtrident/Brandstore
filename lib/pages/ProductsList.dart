import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brandstore/pages/ProductDetailsPage.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsList extends StatefulWidget{

  final mail,path1,path2,path3;

  ProductsList({Key key,this.mail,this.path1,this.path2,this.path3}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  QuerySnapshot _querySnapshot;
  bool ready=false;
  Future queryData2() async{
    return  Firestore.instance.collection(widget.path1).
    document(widget.path2).collection(widget.path3).getDocuments().then((value) =>
        setState(() {
          _querySnapshot=value;
          ready=true;

        }));
  }

  @override
  void initState() {
    queryData2();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Products List"),backgroundColor: Color(0xff0f4c81)),

      body:  Column(
        children: [

          ready? Expanded(
            child: Container(
              color: Colors.black12,
              child: _querySnapshot.documents.length ==0? Container(
                  child: Center(
                    child: Text("Nothing Found"),
                  )
              ):
              GridView.count(

                // crossAxisCount is the number of columns
                crossAxisCount: 2,
                //   childAspectRatio: (itemWidth / itemHeight),
                childAspectRatio: (100 / 180),
                // This creates two columns with two items in each column
                children: List.generate(_querySnapshot.documents!=null ?_querySnapshot.documents.length:0, (index) {

                  var products = _querySnapshot.documents[index];

                  var price =  int.parse(products["price"]);
                  assert(price is int);
                  var offer = int.parse(products["offer"]);
                  assert(offer is int);
                  var finalprice = (price*offer)/100;
                  var finalpricexx = price-finalprice;
                  var finalpricexxx=  finalpricexx.round();
                  return  Container(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Category",
                            snapshot: _querySnapshot.documents[index],
                          path2: "SubCategory",path3: widget.path3,path4:index.toString(),mail: widget.mail,) ));

                      },
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),

                        child:  Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width*0.7,
                              width: MediaQuery.of(context).size.width*0.5,

                              child:  ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(products["pic1"],

                                  fit: BoxFit.cover,
                                  loadingBuilder: (context,child,progress){
                                    return progress == null ? child : CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),

                              child:  Text(products["name1"],maxLines: 1,style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                color: Colors.white,

                              ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),

                              child: Text(products["name2"],maxLines: 1,style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600 ,
                                  fontFamily: "Roboto",
                                  color: Colors.white
                              ),
                              ) ,
                            ),
                            Container(
                              color: Colors.black54,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: [
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
                                    child: Text("₹"+products["price"],style: TextStyle(
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
                                    child: Text(products["offer"]+"%off",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,

                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                      ),

                    ),
                  );
                }
                ),
              ),
            ),
          ):Center(
            child: Container(
              child: Text("Loading"),
            ),
          ),
        ],

      )
    );
  }
}


