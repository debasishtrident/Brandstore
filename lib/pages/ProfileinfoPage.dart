import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:progress_dialog/progress_dialog.dart';
class Profileinfo extends StatelessWidget{


  String username = "";

  Profileinfo({Key key, this.username}) : super(key: key);

  TextEditingController name=new TextEditingController();
  TextEditingController gmail=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController gender=new TextEditingController();
  TextEditingController password=new TextEditingController();

  final databaseReference = Firestore.instance;
  StorageReference storageReference = FirebaseStorage.instance.ref();
  ProgressDialog pr;



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
      StorageUploadTask storageUploadTask = ref.child(username).putFile(image);

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
        Firestore.instance.collection(username)
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    String pic;
    AssetImage assetImage = AssetImage("images/logo1.png");
    Image imagex = Image(
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
        appBar: AppBar( title: Text("Info"),backgroundColor: Color(0xff0f4c81)),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(top: 80),
                      height: 150,
                      width: 120,
                      margin: EdgeInsets.only(top: 20,left: 15,bottom: 20,right: 10),
                      child: GestureDetector(
                        onTap: (){
                          getImage(ImgSource.Both,context);
                        },
                        child: StreamBuilder(
                            stream: Firestore.instance.collection(username).document("PersonalInfo").snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              var userDocument = snapshot.data;
                              pic = userDocument["profilePic"];
                              if(pic==""){
                                return Container(

                                  child: imagex,
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
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 6,top: 8),
                          alignment: Alignment.topLeft,
                          child: Text("user since:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection(username).document("PersonalInfo").snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return Container(
                                padding: EdgeInsets.only(left: 6,top: 8),
                                alignment: Alignment.topLeft,
                                child: Text(userDocument["usercreated"],style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black38),),
                              );
                            }
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 6,top: 8),
                          alignment: Alignment.topLeft,
                          child: Text("Last login:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection(username).document("PersonalInfo").snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return Container(
                                padding: EdgeInsets.only(left: 6,top: 8),
                                alignment: Alignment.topLeft,
                                child: Text(userDocument["lastlogin"],style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black38),),
                              );
                            }
                        ),


                      ],
                    )
                  ],
                ),


                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Name:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),

                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      name.text=userDocument["name"];
                      // picture1[index] = userDocument["pic1"];
                      return  Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          controller: name,

                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none,),
                          //readOnly: true,
                        ),
                      );
                    }
                ),

                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Gmail:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      gmail.text=userDocument["email"];
                      // picture1[index] = userDocument["pic1"];
                      return     Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          controller: gmail,
                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none),
                           readOnly: true,
                        ),
                      );
                    }
                ),
                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Password:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      password.text=userDocument["password"];
                      // picture1[index] = userDocument["pic1"];
                      return     Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none),
                          readOnly: true,
                        ),
                      );
                    }
                ),
                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Phone:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),

                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      phone.text=userDocument["phone"];
                      // picture1[index] = userDocument["pic1"];
                      return  Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          controller: phone,
                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none),
                          //readOnly: true,
                        ),
                      );
                    }
                ),

                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Dob:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),

                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      dob.text=userDocument["dob"];
                      // picture1[index] = userDocument["pic1"];
                      return   Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          maxLines: 1,
                           maxLengthEnforced: true,
                          controller: dob,
                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none,hintText: "06/05/98"),
                          //readOnly: true,
                        ),
                      );
                    }
                ),

                Container(
                  padding: EdgeInsets.only(left: 6,top: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Gender:",style: TextStyle(fontSize: 20,fontFamily: "Raleway",fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection(username).document('PersonalInfo').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      gender.text=userDocument["gender"];
                      // picture1[index] = userDocument["pic1"];
                      return Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,

                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.only(left: 6),

                        child:  TextField(
                          controller: gender,

                          style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none,hintText: "male/female",),
                          //readOnly: true,
                        ),
                      );
                    }
                ),


                Container(
                  width: 300.0,
                  height: 50.0,
                  margin: EdgeInsets.only(top: 30.0, bottom: 15),
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFFceced8))),
                    onPressed: () {

                               databaseReference.collection(username).document('PersonalInfo').updateData({
                                 "name":name.text,
                                 "phone":phone.text,
                                 "gender":gender.text,
                                 "dob":dob.text,

                                    });

                                Fluttertoast.showToast(msg: "Updated successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                   backgroundColor: Colors.teal,textColor: Colors.white);

                    },
                    child: Text('Update', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
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