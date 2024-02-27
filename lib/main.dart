import 'package:flutter/material.dart';
import 'RestraurantSearch.dart';
import 'Function.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Restaurant Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: RestraurantSearch(),
    );
  }
}