import 'package:flutter/material.dart';
import 'package:my_app/pages/card_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CardValidator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardPage(),
    );
  }
}
