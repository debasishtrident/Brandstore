import 'package:brandstore/pages/ProfileinfoPage.dart';
import 'package:brandstore/pages/payment.dart';
import 'package:brandstore/practice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brandstore/pages/CategoryPage.dart';
import 'package:brandstore/pages/ContactUsPage.dart';
 import 'package:brandstore/pages/GiftStorePage.dart';
import 'package:brandstore/pages/MyAccountPage.dart';
import 'package:brandstore/pages/MyCartPage.dart';
import 'package:brandstore/pages/MyOrdersPage.dart';
import 'package:brandstore/pages/OfferZonePage.dart';
import 'package:brandstore/pages/SettingPage.dart';
import 'package:brandstore/pages/SharePage.dart';
import 'package:brandstore/pages/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavDrawer extends StatelessWidget {
  final username;

  NavDrawer({Key key, this.username,}) : super(key: key);
  final databaseReference = Firestore.instance;


  @override
  Widget build(BuildContext context) {

    String pic;
    AssetImage assetImage = AssetImage("images/logo1.png");
    Image image = Image(
      image: assetImage,
    );
    return Drawer(
      elevation: 20.0,

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Profileinfo(username: username)));
            },
            child: UserAccountsDrawerHeader(
              accountName:  Container(

                child: StreamBuilder(
                    stream: Firestore.instance.collection(username).document("PersonalInfo").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;

                      return Text(userDocument["name"]);


                    }
                ),
              ),
              accountEmail: Text(username),
              currentAccountPicture: StreamBuilder(
                  stream: Firestore.instance.collection(username).document("PersonalInfo").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocument = snapshot.data;
                    pic = userDocument["profilePic"];
                    if(pic==""){
                      return Container(
                        child:image,
                      );
                    }
                    else{
                      return   Container(

                        height: 250,
                        width: 176,
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:  ClipOval(
                            // borderRadius: BorderRadius.circular(20),
                            child: Image.network(pic),
                          ),
                        ),
                      );
                    }

                  }
              ),

            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            selected: true,
            title: Text('Home'),
//            onTap: () =>{Navigator.of(context).pop(),Navigator.of(context).push(
//              MaterialPageRoute(builder: (context) => SignUpPage()),),},
          ),

          ListTile(
            leading: Icon(Icons.category),
            title: Text('Category'),
            onTap: () => {
              Navigator.of(context).pop(),Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CategoryPage(mail: username,),),)
            },
          ),

          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Offer Zone'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OfferZonePage(mailx: username,)))},
          ),
          Divider(
            color: Colors.black54,
            height: 1.5,
            thickness: 1.5,
            indent: 30,
            endIndent: 30,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Account'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyAccountPage(username: username,)))},
          ),
          ListTile(
            leading: Icon(Icons.featured_play_list),

            title: Text('My Orders'),
            onTap: () => {
              Navigator.of(context).pop(),Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyOrdersPage(username: username,)))
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),

            title: Text('My Cart'),
            onTap: () => {
          Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen(mail: username,)))
            },
          ),
          Divider(
            color: Colors.black54,
            height: 1.5,
            thickness: 1.5,
            indent: 30,
            endIndent: 30,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingPage(),))},
          ),
          ListTile(
            leading: Icon(Icons.perm_phone_msg),
            title: Text('Contact Us'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  ContactUsPage()))},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SharePage()))},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () =>
            {
              Navigator.of(context).pop(),
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
            ),
            }
          ),
        ],
      ),
    );
  }
}


