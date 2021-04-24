
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MyPointsPage extends StatelessWidget{


  String username;

  MyPointsPage({Key key, this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
      appBar: AppBar( title: Text("My Points"),backgroundColor: Color(0xff0f4c81)),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(7),
          child: Column(
            children: <Widget>[
              UserCard(user: username,),
              Container(
                alignment: Alignment.topLeft,
                //height: 320,
                margin: EdgeInsets.all(6),
                child:
                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('Orderinfo').collection("Points").document("max").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      // picture1[index] = userDocument["pic1"];
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userDocument["length"],
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              StreamBuilder(
                                  stream: Firestore.instance.collection(username).document('Orderinfo').collection("Points").document("a"+index.toString()).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    var userDocument = snapshot.data;
                                    // picture1[index] = userDocument["pic1"];
                                    return  Container(
                                      width: 100.0,
                                      padding: EdgeInsets.all(8),

                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: new BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(2),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(userDocument["date"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),
                                              Text(userDocument["msg"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),
                                              Text(userDocument["value"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),
                                            ],
                                          )

                                        ],
                                      ),
                                    );
                                  }
                              );


                          });
                    }
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }

}

class UserCard extends StatelessWidget{
  final user;

  const UserCard({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),

      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF05135C),
              Color(0xFF242121),
            ]
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 200,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("CLASSIC",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),
              Text("BS2020",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child:Text("Total BrandStore Points",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),
          ),
          StreamBuilder(
              stream: Firestore.instance.collection(user).document('Orderinfo').collection("Points").document("max").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return Container(
                  margin: EdgeInsets.only(top: 15),
                  child:Text(userDocument["total"].toString(),textAlign: TextAlign.center,style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
                );
              }
          ),

          StreamBuilder(
              stream: Firestore.instance.collection(user).document('PersonalInfo').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 15),
                  child:Text(userDocument["name"],textAlign: TextAlign.start, style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),

                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection(user).document('PersonalInfo').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return  Container(
                  width: 300,
                  //margin: EdgeInsets.only(top: 5),
                  child: Text("#"+userDocument["cvv1"].toString()+"/"+userDocument["cvv2"].toString(),textAlign: TextAlign.start,style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),
                );
              }
          ),

          Container(
            width: 300,
            //margin: EdgeInsets.only(top: 5),
            child: Text("T&C",textAlign: TextAlign.end, style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 13,color: Colors.white),),

          ),

        ],
      ),
    );
  }

}