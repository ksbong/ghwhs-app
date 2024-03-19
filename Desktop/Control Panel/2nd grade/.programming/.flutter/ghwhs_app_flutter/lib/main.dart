import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/screens/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
        title: '광혜원고',
        debugShowCheckedModeBanner: false,
        // home: TestComponent(),
        home: HomePage());
  }
}
