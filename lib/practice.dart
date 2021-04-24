import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Practice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Text("get"),
            onPressed: (){
              Firestore.instance.collection('Homepage').document('SubHomepage').collection('onOffer')
                  .snapshots()
                  .listen((data) =>
                  data.documents.forEach((doc) => countDocuments()));
        })  
      ),
    );
  }
}


void countDocuments()   {
     print(Firestore.instance.collection('Homepage').document('SubHomepage').collection('onOffer').snapshots().length.toString());
   // Count of Documents in Collection
}