import 'package:flutter/material.dart';
import 'package:viginesia_app/color.dart';
import 'package:viginesia_app/pages/login.dart';
import 'package:viginesia_app/pages/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 208, 215, 5),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                "Vigenesia",
                style: TextStyle(fontSize: 35, fontWeight: bold),
              ),
              Text(
                "Aplikasi untuk berbagi cerita apapun yang mahasiswa ingin ungkapkan",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryButtonColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Masuk",
                      style: TextStyle(fontSize: 17, fontWeight: bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
