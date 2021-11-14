import 'package:flutter/material.dart';
import 'package:flutter_app/view/HomeView.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blue Auto Music',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
          accentColor: Colors.white,
          accentIconTheme: IconThemeData(color: Colors.black),
          dividerColor: Colors.black12,
        ),
        home: HomeView()
    );
  }
}










