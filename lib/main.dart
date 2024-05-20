import 'package:flutter/material.dart';
import 'package:tastybud/Pages/Home_Screen.dart';
import 'package:tastybud/Pages/Search_Recipe_by_Ingredients.dart';


void main() {
  runApp(const TastyBud());
}
class TastyBud extends StatelessWidget {
  const TastyBud({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Food recipe',
      theme: ThemeData(
        primaryColor: Colors.white,primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white)
        )

      ),
      debugShowCheckedModeBanner: false,
      home: Home(),

    );
  }
}
