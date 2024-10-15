import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  late int num1;
  late int num2;
  late String op;

  bool isInitialized = false;
  bool isOperationSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Text("ESCOLHER OPERAÇÃO", style: TextStyle(color: Colors.yellowAccent),),
          onPressed: () {
            setState(() {
              isOperationSelected = !isOperationSelected;
            });
          },
        ),
        DropdownMenu(
          width: 250,
          label: Text("Escoler operação matemática desejada", style: TextStyle(color: Colors.white),),
          textStyle: TextStyle(color: Colors.yellowAccent),
          onSelected: (x) {
            if (x != null) {
              op = x;
            }
          },
            dropdownMenuEntries: [
              DropdownMenuEntry(
                  value: "+",
                  label: "+"
              ),
              DropdownMenuEntry(
                  value: "-",
                  label: "-"
              ),
              DropdownMenuEntry(
                  value: "x",
                  label: "x"
              ),
              DropdownMenuEntry(
                  value: "/",
                  label: "/"
              ),
            ]
        ),
        SizedBox(height: 100,),
        TextButton(
          child: Text("OBTER CONTA", style: TextStyle(color: Colors.yellowAccent),),
          onPressed: () {
            setState(() {
              Random random = new Random();
              num1 = random.nextInt(10);
              num2 = random.nextInt(10);
              isInitialized = true;
            });
          },
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         if (isInitialized) ...[
           Text("${num1}", style: TextStyle(color: Colors.orange)),
           Text("${op}", style: TextStyle(color: Colors.orange),),
           Text("${num2}", style: TextStyle(color: Colors.orange)),
         ],       ],
      )
      ],
    );
  }
}
