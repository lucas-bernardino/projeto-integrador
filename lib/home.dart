import 'package:balanca/game.dart';
import 'package:balanca/serial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isDebug = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          SizedBox(height: 50,),
          TextButton(
              onPressed: () {
                setState(() {
                  isDebug = !isDebug;
                });
              },
              child: Text("Modo Debug")
          ),
          SizedBox(height: 350,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Game(),
              isDebug ? Serial() : SizedBox(),
            ],
          ),
        ],
      ),
    );

  }
}
