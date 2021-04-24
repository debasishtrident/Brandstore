import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:clay_containers/clay_containers.dart';


class GiftStorePage extends StatelessWidget {

  final String username;

  const GiftStorePage({Key key, this.username}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);
    final width =MediaQuery.of(context).size.width;
    final height =MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar( title: Text("Gifts"),backgroundColor: Color(0xff0f4c81)),
        body: Container(
         color: Colors.white10,
         child: Stack(
          // fit: StackFit.expand,
        //  overflow: Overflow.visible,
          children: <Widget>[
//            Positioned(
//              top: 1.0,
//              left: 1.0,
//              child: Align(
//                  heightFactor: 0.5,
//                  widthFactor: 0.5,
//                  alignment: Alignment.bottomRight,
//                  child:  Material(
//                    borderRadius: BorderRadius.all(Radius.circular(200)),
//                    color: Color.fromRGBO(255, 255, 255, 0.5),
//                    child: Container(
//                      height: 400,
//                      width: 400,
//                    ),
//                  )
//              ),
//            ),
           //  backgroundDesign(width: width * 0.4,height: height * 0.8,),


//            Positioned(
//
//              child: Align(
//                alignment: Alignment.bottomCenter,
//                child: ClipPath(
//                  clipper: CharacterCardBackgroundClipper(),
//                  child: Container(
//                    height: 280,
//                    width: 220,
//                    alignment: Alignment.topCenter,
//                    color: Colors.white,
//                    child: Align(
//                      alignment: Alignment.topCenter,
//                      child:Icon(Icons.phone_android,size: 200,),
//                    ),
//
//                  ),
//                ),
//              )
//            )
          Align(
            alignment: Alignment.center,
              child: Text("Coming soon")),
          ],
        ),
      )

    );
  }


}

class backgroundDesign extends StatelessWidget{
  final double height,width;

  const backgroundDesign({Key key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Positioned(
      height: height,
      width: width,
      right: 0.0,
      top: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        child: Container(
          color: Colors.blueAccent,
      ),
     )
    );
  }

}
class Texty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(

      child: Text("ass"),
    );

  }

}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(
        size.width + 1, size.height - 1, size.width, size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(
        size.width - 1, 0, size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


