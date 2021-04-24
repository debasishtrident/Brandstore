import 'package:brandstore/pages/ProductsList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CategoryPage extends StatefulWidget {
  final mail;

  CategoryPage({Key key,this.mail}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar( title: Text("Category"),backgroundColor: Color(0xff0f4c81)),
      body: Center(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(),),);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:widget.mail,
                          path1: "Category",path2: "SubCategory",path3: "TShirts",),),);

                      },
                      child: Tshirtcard(),
                    ),
                    GestureDetector(
                        onTap: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(),),);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:widget.mail,
                            path1: "Category",path2: "SubCategory",path3: "Pants",),),);

                        },
                        child: Pantscard(),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:widget.mail,
                             path1: "Category",path2: "SubCategory",path3: "Shoes"),),);
                      },
                     child: Shoescard(),
                    ),
                    GestureDetector(
                      onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:widget.mail,
                           path1: "Category",path2: "SubCategory",path3: "Watches",),),);
                        //Fluttertoast.showToast(msg: "No data",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                      },
                      child:  Watchescard(),
                    ),

                  ],
                ),

                GestureDetector(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(mail:widget.mail,
                      path1: "Category",path2: "SubCategory",path3: "Sunglasses",),),);

                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsList(),),);
                   },
                  child: Sunglasscard(),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }
}



class Namex extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text("SIDHARTHA SEKHAR",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.white,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,


        ),),
    );
  }
}
class Phonex extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text("+91 8114613927",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.white,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,


        ),),
    );
  }
}

class Tshirtcard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      width: 160,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          tshirticon(),
          tshorttext(),
        ],
      ),
    );
  }
}
class tshirticon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/tshirt.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFF394FC2),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class tshorttext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Tshirt",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class Pantscard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      width: 160,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          pantsicon(),
          pantstext(),
        ],
      ),
    );
  }
}
class pantsicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/pants.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFE98929),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class pantstext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Pants",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class Shoescard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      width: 160,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          Shoesicon(),
          Shoestext(),
        ],
      ),
    );
  }
}
class Shoesicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/shoes.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFFA2F2F),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class Shoestext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Shoes",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class Watchescard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      width: 160,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          Watchesicon(),
          Watchestext(),
        ],
      ),
    );
  }
}
class Watchesicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/watch.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFF009688),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class Watchestext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Watches",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class Sunglasscard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
       margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          Sunglassicon(),
          Sunglasstext(),
        ],
      ),
    );
  }
}
class Sunglassicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/sunglasses.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFD52E64),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class Sunglasstext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Sunglasses",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class BagsAndWalletcard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      width: 160,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(
        children: <Widget>[
          BagsAndWalleticon(),
          BagsAndWallettext(),
        ],
      ),
    );
  }
}
class BagsAndWalleticon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/bag.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFF7C46DB),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class BagsAndWallettext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Bags/Wallet",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}

class SportsAccessoriescard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 160,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),

      decoration: BoxDecoration(
          color: Color(0xFFe7e7e7),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Column(

        children: <Widget>[
          SportsAccessoriesicon(),
          SportsAccessoriestext(),
        ],
      ),
    );
  }
}
class SportsAccessoriesicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=new AssetImage("images/sportaccessorie.png");
    Image image=Image(image: assetImage,);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFF1CC423),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
      ),
      height: 70,
      width: 70,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child:   image,

    );
  }

}
class SportsAccessoriestext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text("Sports ",textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.teal,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

}