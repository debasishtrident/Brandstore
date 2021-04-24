
 import 'dart:io';
 import 'package:brandstore/pages/MyCartPage.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:brandstore/pages/AddressPage.dart';
import 'package:brandstore/pages/ChangePasswordPage.dart';
import 'package:brandstore/pages/MyOrdersPage.dart';
import 'package:brandstore/pages/MyPointsPage.dart';
import 'package:brandstore/pages/ProfileinfoPage.dart';
import 'package:brandstore/pages/SettingPage.dart';
import 'package:brandstore/pages/SharePage.dart';
import 'package:brandstore/pages/SignInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
 class MyAccountPage extends StatefulWidget{

   String username;

   MyAccountPage({Key key, this.username}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {


   StorageReference storageReference = FirebaseStorage.instance.ref();

   ProgressDialog pr;

   bool ready=false;

   QuerySnapshot OrderSnapshot,CartSnapshot;
   Future getImage(ImgSource source,BuildContext context) async {
     var image = await ImagePickerGC.pickImage(context: context, source: source,
       cameraIcon: Icon(Icons.camera, color: Colors.red,
       ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
     );
     try {
       //CreateRefernce to path.
       StorageReference ref = storageReference.child("userProfilePic/");

       //StorageUpload task is used to put the data you want in storage
       //Make sure to get the image first before calling this method otherwise _image will be null.
       await pr.show();
       StorageUploadTask storageUploadTask = ref.child(widget.username).putFile(image);

       if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
         final String url = await ref.getDownloadURL();
         //  print("The download URL is " + url);
       } else if (storageUploadTask.isInProgress) {
         storageUploadTask.events.listen((event) {
           double percentage = 100 * (event.snapshot.bytesTransferred.toDouble()
               / event.snapshot.totalByteCount.toDouble());

           //  print("THe percentage " + percentage.toString());
           pr = ProgressDialog(context, type: ProgressDialogType.Download,
               isDismissible: false,
               showLogs: true);
         });

         StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask
             .onComplete;

         var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
         Firestore.instance.collection(widget.username)
             .document("PersonalInfo")
             .updateData({
           "profilePic": downloadUrl1,

         });
         //Here you can get the download URL when the task has been completed.
         // print("Download URL " + downloadUrl1.toString());
         await pr.hide();
       } else {
         await pr.hide();

         //Catch any cases here that might come up like canceled, interrupted
       }
     } catch (e) {
       print(e.toString());
     }
   }
   Future queryData() async{
     return  Firestore.instance.collection("Homepage").document('SubHomepage').collection("onOffer").
     getDocuments().then((value) =>

         setState(() {
           OrderSnapshot=value;
         }));
   }
   Future queryData2() async{
     return  Firestore.instance.collection("Homepage").document('SubHomepage').collection("onTrend").
     getDocuments().then((value) =>

         setState(() {
           CartSnapshot=value;
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
    // TODO: implement buildj
    String pic;
    AssetImage assetImage = AssetImage("images/logo1.png");
    Image image = Image(
      image: assetImage,
    );

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Uploading Image...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      appBar: AppBar( title: Text("Account"),backgroundColor: Color(0xff0f4c81)),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
             // maincard2(username),
              Stack(
               // alignment: Alignment.center,
              children: <Widget>[
                Container(

                  //margin: EdgeInsets.only(top: 80),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                  ),
                  //margin: EdgeInsets.only(top: 80),
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                   top: 80,
                  left: MediaQuery.of(context).size.width*0.5-50,
                  child:   Container(
                    //margin: EdgeInsets.only(top: 80),
                    height: 100,
                    width: 100,
                    child: GestureDetector(
                      onTap: (){
                        getImage(ImgSource.Both,context);
                      },
                      child: StreamBuilder(
                          stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            pic = userDocument["profilePic"];
                            if(pic==""){
                              return Container(

                                child: image,
                              );
                            }
                            else{
                              return CircleImageInkWell(
                                size: 100,
                                image: NetworkImage(pic),
                              );
                            }

                          }
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 190,
                  left: MediaQuery.of(context).size.width*.5-130,
                  child: StreamBuilder(
                      stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        return Container(
                          width: 260,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(70),
                                bottomRight: Radius.circular(70),
                              )
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Text(userDocument["name"],maxLines:1,textAlign: TextAlign.center,textDirection: TextDirection.ltr,
                            style: TextStyle(decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );

                      }
                  ),
                ),
                Positioned(
                  top: 230,
                  left: MediaQuery.of(context).size.width*0.5-80,
                  child:  StreamBuilder(
                      stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;

                        return Container(
                          width: 160,
                           margin: EdgeInsets.only(top: 15,bottom: 30),
                          child: Text("+91"+userDocument["phone"],maxLines:1,textAlign: TextAlign.center,textDirection: TextDirection.ltr,
                            style: TextStyle(decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,


                            ),),
                        );

                      }
                  ),
                ),
                Positioned(
                  top: 290,

                  height: 110,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),

                          ),
                        border: Border.all(color: Colors.teal,style: BorderStyle.solid,width: 1.5)
                      ),
                    width: MediaQuery.of(context).size.width-50,
                    margin: EdgeInsets.only(left: 25,right: 25),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    Row(
                    children: <Widget>[

                        GestureDetector(
                        onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersPage(username: widget.username,)));

                  },
                    child:   Column(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          child: Icon(Icons.featured_play_list,color: Colors.blueAccent,),
                        ),
                        Divider(
                          height: 5,
                        ),
                        Container(
                          width: 70,
                          child: Text("ORDER",textAlign: TextAlign.center,style: TextStyle(

                            fontSize: 16,fontFamily: "Raleway",fontWeight:FontWeight.w600,
                          ),),
                        )
                      ],
                    ),
                  ),

                  VerticalDivider(
                    indent: 30,endIndent: 30,
                    width: 20,
                    thickness: 2,
                    color: Colors.teal,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersPage(username: widget.username,)));

                    },
                    child: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child:  Text("total\n"+OrderSnapshot.documents.length.toString(),textAlign: TextAlign.center,style: TextStyle(

                        fontSize: 16,fontFamily: "Raleway",
                      ),),
                    ),
                  )


                  ],
                ),

                        VerticalDivider(
                          indent: 10,endIndent: 10,
                          width: 2,
                          thickness: 2,
                          color: Colors.teal,
                        ),
                                Row(
                                children: <Widget>[
                                GestureDetector(
                                onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(mail: widget.username,)));

                          },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child:  Text("total\n"+CartSnapshot.documents.length.toString(),textAlign: TextAlign.center,style: TextStyle(

                                fontSize: 16,fontFamily: "Raleway",
                              ),),
                            ),
                          ),

                          VerticalDivider(
                            indent: 30,endIndent: 30,
                            width: 20,
                            thickness: 2,
                            color: Colors.teal,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(mail: widget.username,)));
                            },
                            child:
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  alignment: Alignment.center,
                                  child: Icon(Icons.shopping_cart,color: Colors.blueAccent,),
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Container(
                                  width: 70,
                                  child: Text("CART",textAlign: TextAlign.center,style: TextStyle(

                                    fontSize: 16,fontFamily: "Raleway",fontWeight:FontWeight.w600,
                                  ),),
                                )
                              ],
                            ),

                          ),


                          ],
                        ),




                      ],
                    )
                  ),
                ),
            ],
           ),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profileinfo(username: widget.username,)));
                },
                child: Personalinfo(),
              ),

              Divider(
                height: 1,
                color: Colors.teal,

              ),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersPage(username: widget.username,)));
                },
                child: Orders(),
              ),
              Divider(
                height: 1,
                color: Colors.teal,

              ),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressPage(username: widget.username,)));
                },
                child: Address(),
              ),

              //
              // Divider(
              //   height: 1,
              //   color: Colors.teal,
              // ),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPointsPage(username: username,)));
              //   },
              //   child: Points(),
              // ),

              Divider(
                height: 1,
                color: Colors.teal,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SharePage(username: widget.username,)));
                },
                child:   Share(),
              ),

              // Divider(
              //   height: 1,
              //   color: Colors.teal,
              // ),
              //
              // GestureDetector(
              //   onTap: (){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangPass(username: username,)));
              //   },
              //   child: ChangePassword(),
              // ),

              Divider(
                height: 1,
                color: Colors.teal,
              ),

              GestureDetector(
                onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage(),),);
                 // Fluttertoast.showToast(msg: "No data",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                },
                child: Settings(),
              ),
                 LogoutButton(),

            ],
          ),
        )
      ),
    );
  }
}



class Personalinfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon1(),
         Expanded(
           child:  Text1(),
         ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.person,color: Colors.teal,),
    );
  }
}
class Text1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Profile info.",textDirection: TextDirection.ltr,style: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontFamily: "Raleway"
      ),),
    );
  }
}

class nexticon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.navigate_next,color: Colors.teal,)
    );
  }
}

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon2(),
          Expanded(
            child:  Text2(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.featured_play_list,color: Colors.teal,),
    );
  }
}
class Text2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Orders",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
      ),),
    );
  }
}

class Address extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon3(),
            Expanded(
              child:  Text3(),
            ),
            nexticon(),
          ],
        ),
      );

  }
}
class Icon3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.location_on,color: Colors.teal,),
    );
  }
}
class Text3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Address",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
       ),
      ),
    );
  }
}

class Points extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon4(),
          Expanded(
            child:  Text4(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.attach_money,color: Colors.teal,),
    );
  }
}
class Text4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Points",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
       ),
      ),
    );
  }
}

class Share extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon5(),
          Expanded(
            child:  Text5(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.share,color: Colors.teal,),
    );
  }
}
class Text5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Share And Earn",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
      ),),
    );
  }
}

class ChangePassword extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon6(),
          Expanded(
            child:  Text6(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon6 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.lock,color: Colors.teal,),
    );
  }
}
class Text6 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Change Password",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
      ),),
    );
  }
}

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon7(),
          Expanded(
            child:  Text7(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon7 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.settings,color: Colors.teal,),
    );
  }
}
class Text7 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Change Settings",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Raleway"
      ),),
    );
  }
}

class LogoutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          //color: Color(0xFF394FC2),
          color: Colors.teal,
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      width: 300,
      height: 45.0,
      margin: EdgeInsets.only(left: 15.0,top: 20.0,right: 15,bottom: 20),
      child: RaisedButton(
        onPressed: () {

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Logout!",style: TextStyle(color: Colors.white,fontSize: 20),),
                  content: Text("Are you fucking sure?",style: TextStyle(color: Colors.white,fontSize: 17),),
                  actions: <Widget>[
                    FlatButton( onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text("No",style: TextStyle(color: Colors.white,fontSize: 17),),),
                    FlatButton(onPressed: () async {
                      Navigator.pop(context);
                      Navigator.of(context).pop(context);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('email');
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );

                     },child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 17),),),
                  ],
                  elevation: 24.0,
                  backgroundColor: Colors.blue,
                );
              }
          );
        },
        child: Text("LOG OUT"),
        color: Colors.teal,
        textColor: Color(0xFFffffff),

      ),

    );
  }

}