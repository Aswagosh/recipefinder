import 'package:flutter/material.dart';
import 'package:tastybud/Pages/Search_Recipe_by_Ingredients.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final urlimg =
      "https://i.pinimg.com/736x/ff/9c/64/ff9c64e0745187dcbec4081a3733883b.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(urlimg), fit: BoxFit.cover)),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Text(
                  "TastyBud",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Anton',
                      letterSpacing: 5),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Center(
                child: Text(
                  "Let's find some foods for you",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gorditas'),
                ),
              ),
              SizedBox(
                height: 500,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontFamily: 'Gorditas'))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchByIngredients()));
                  },
                  child: Text(
                    "Let's Cook",
                    style: TextStyle(
                        wordSpacing: 5, color: Colors.black, fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
