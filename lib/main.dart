import 'package:flutter/material.dart';
import 'package:pray/pages/home_page.dart';
import 'package:pray/pages/lodaing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pray',
      initialRoute: '/',
      routes: {
        "/" : (context) => LoadingPage(), //page loaging
        "/home" : (context) => HomePage() // page home
      },

    );
  }
}

