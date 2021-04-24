 import 'package:flutter/material.dart';

 import 'package:dotted_border/dotted_border.dart';
class SharePage extends StatelessWidget{


  String username = "";

  SharePage({Key key, this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
      appBar: AppBar( title: Text("Share"),backgroundColor: Color(0xff0f4c81)),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50,bottom: 20),

                child:DottedBorder(
                  color: Color(0xFF3288CE),
                  radius: Radius.circular(40),
                  dashPattern: [3,5],
                  strokeWidth: 2,
                  borderType: BorderType.Circle,
                  strokeCap: StrokeCap.square,
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Color(0xFF3288CE),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Text("₹ 25", style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.white),),
                  ),
                ),
              ),
              Text("Refer a friend and you'll each earn ₹25",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,fontFamily: "Raleway",fontWeight: FontWeight.w600,color: Colors.black54),),
              Container(
                margin: EdgeInsets.only(top: 30,bottom: 15),
                child:  Text("Share this link with your friends",textAlign: TextAlign.center,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    color: Color(0xFF015204),
                    height: 30,
//                    margin: EdgeInsets.only(left: 40),
//                    padding: EdgeInsets.only(left: 7),


                    child:  Text("https://link.me/6hyjy/ty677....",textAlign: TextAlign.center,style: TextStyle(
                      fontFamily: "Raleway",fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700,
                    ),),
                  ),
                  Container(
                       child: Icon(Icons.content_copy,size: 30,)
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30,bottom: 20),
                child: Icon(Icons.share,color: Colors.green,size: 50,),
              ),
              Text("Invite your friends to join Cornerstore\n and both of you get ₹ 25 on their\n first shoping. Max cashback ₹250",textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic), ),
              Divider(color: Colors.black,height: 35,thickness: 1,endIndent: 35,indent: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),

                    child:  Text("Your Referral Dashboard",textAlign: TextAlign.center,style: TextStyle(
                      fontFamily: "Raleway",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600,
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child:  Text("You Earned ₹0.00",textAlign: TextAlign.center,style: TextStyle(
                      fontFamily: "Raleway",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600,
                    ),),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 30,bottom: 10),
                child:  Text("₹0.00",textAlign: TextAlign.center,style: TextStyle(
                  fontFamily: "Raleway",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700,
                ),),
              ),
              Container(
                 alignment: Alignment.bottomRight,
                margin: EdgeInsets.only( bottom: 20),  
                padding: EdgeInsets.only(right: 15),
                child:  Text("T&C",textAlign: TextAlign.end,style: TextStyle(
                  fontFamily: "Raleway",fontSize: 15,color: Color(0xFF3288CE),fontWeight: FontWeight.w500,
                ),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
