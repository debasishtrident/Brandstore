import 'package:brandstore/pages/HomePage.dart';
import 'package:brandstore/pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  print(email);
  runApp(
      MaterialApp(
       home: email == null ? SignInPage() : MyHomePage(username: email,),
        debugShowCheckedModeBanner: false,
   )
  );
}

