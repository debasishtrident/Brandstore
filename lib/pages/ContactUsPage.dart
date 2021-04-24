
import 'package:flutter/material.dart';
class ContactUsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
      appBar: AppBar( title: Text("Contact"),backgroundColor: Color(0xff0f4c81)),
      body: SingleChildScrollView(
        child:  Container(
          padding: EdgeInsets.all(7),
          child: Column(
            children: <Widget>[
              Phonecontact(),
              Emailcontact(),
              Offlinecontact(),
            ],
          ),
        ),
      ),
    );
  }

}

class Phonecontact extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFC0C7EB),
              Color(0xFF8D7E7E),
          ]
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child:Icon(Icons.phone_android,color: Colors.white,size: 80,),
          ),

           VerticalDivider(width:2,thickness:2,color: Colors.white,indent: 10,endIndent: 10,),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 220,
                margin: EdgeInsets.only( top: 8),
                child: Text("8114613927/8249898957",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 220,
                margin: EdgeInsets.only(top: 8),
                child: Text("Monday to Saturday",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              Text("9 AM to 9 PM",
                style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Container(
                alignment: Alignment.center,

                height: 25,
                width: 200,
                margin:
                EdgeInsets.only(top: 8),
                child: Text("Sunday",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              Text("9 AM to 6 PM",
                style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
class Emailcontact extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFC0C7EB),
              Color(0xFF8D7E7E),
            ]
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child:Icon(Icons.mail_outline,color: Colors.white,size: 80,),
          ),

          VerticalDivider(width:2,thickness:2,color: Colors.white,indent: 10,endIndent: 10,),

          Column(

             children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 25,
                 margin: EdgeInsets.only( top: 45),
                padding: EdgeInsets.only( left: 5),

                child: Text("support.brandstore@gmail.com",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 220,
                margin: EdgeInsets.only(top: 8),
                child: Text("Email us for quick response",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),



            ],
          ),
        ],
      ),
    );
  }
}
class  Offlinecontact extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      margin: EdgeInsets.only(top: 10),

      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFC0C7EB),
              Color(0xFF8D7E7E),
            ]
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child:Icon(Icons.location_on,color: Colors.white,size: 80,),
          ),

          VerticalDivider(width:2,thickness:2,color: Colors.white,indent: 10,endIndent: 10,),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 200,
                margin: EdgeInsets.only( top: 8),
                child: Text("Address",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                 width: 220,
                margin: EdgeInsets.only(top: 8),
                child: Text("The Manager,\n 2nd Floor,Skyfox Building,\nPolice chawk,\n Banibihar,Bhubaneswar,\nOdisha, 111111",
                  textAlign: TextAlign.center,style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}