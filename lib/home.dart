import 'package:balanca/game.dart';
import 'package:balanca/serial.dart';
import 'package:balanca/tutorial.dart';
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
      body: Container(
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
              fit: BoxFit.cover,//<--- add this
              image: AssetImage('assets/background.jpg'),
            )),
        child: Column(
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
            SizedBox(height: 200,),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                    child: Text("MATERIAL DOURADO", style: TextStyle(color: Colors.yellow[400], fontSize: 50, fontWeight: FontWeight.w900, backgroundColor: Colors.yellow[900]),)),
                SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellowAccent)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Game()),
                          );
                        },
                        child: Text("Jogar", style: TextStyle(color: Colors.black, fontSize: 20),)
                    ),
                    SizedBox(width: 30,),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellowAccent)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Tutorial()),
                          );
                        },
                        child: Text("Tutorial", style: TextStyle(color: Colors.black, fontSize: 20),)
                    ),
                    isDebug ? Serial() : SizedBox(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
