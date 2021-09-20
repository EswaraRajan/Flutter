import 'package:covid19/Dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      theme: ThemeData(brightness: Brightness.dark),
      home: Startscreen(),
    );
  }
}

class Startscreen extends StatelessWidget {
  const Startscreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/Corona_.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Covid-19\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                    TextSpan(
                      text: "Stay Home Stay Safe",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Dashboard();
                }));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 25.0),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.deepOrangeAccent,
                ),
                child: Row(
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
