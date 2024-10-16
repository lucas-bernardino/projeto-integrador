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

  late double result;

  late String level;

  bool isInitialized = false;
  bool isOperationSelected = false;
  bool shouldShowResult = false;

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
        Row(
          children: [
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
            SizedBox(width: 10,),
            DropdownMenu(
                width: 250,
                label: Text("Selecionar dificuldade", style: TextStyle(color: Colors.white),),
                textStyle: TextStyle(color: Colors.yellowAccent),
                onSelected: (x) {
                  if (x != null) {
                    level = x;
                  }
                },
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: "Facil",
                      label: "Facil"
                  ),
                  DropdownMenuEntry(
                      value: "Dificil",
                      label: "Dificil"
                  ),
                ]
            ),
          ],
        ),
        SizedBox(height: 100,),
        TextButton(
          child: Text("OBTER CONTA", style: TextStyle(color: Colors.yellowAccent),),
          onPressed: () {
            setState(() {
              if (level.contains("Facil")) {
                result = 21;
                while (result > 20 || result == 0) {
                  Random random = new Random();
                  num1 = random.nextInt(10);
                  num2 = random.nextInt(10);
                  switch (op) {
                    case "+":
                      result = num1.toDouble() + num2.toDouble();
                      break;
                    case "-":
                      result = num1.toDouble() - num2.toDouble();
                      break;
                    case "x":
                      result = num1.toDouble() * num2.toDouble();
                      break;
                    case "/":
                      result = num1.toDouble() / num2.toDouble();
                      break;
                  }
                }
              }
              else {
                result = 0;
                while (result == 0) {
                  Random random = new Random();
                  num1 = random.nextInt(10);
                  num2 = random.nextInt(10);
                  switch (op) {
                    case "+":
                      result = num1.toDouble() + num2.toDouble();
                      break;
                    case "-":
                      result = num1.toDouble() - num2.toDouble();
                      break;
                    case "x":
                      result = num1.toDouble() * num2.toDouble();
                      break;
                    case "/":
                      result = num1.toDouble() / num2.toDouble();
                      break;
                  }
                }
              }
              isInitialized = true;
            });
          },
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         if (isInitialized) ...[
           Text("${num1}", style: TextStyle(color: Colors.orange, fontSize: 90)),
           SizedBox(width: 10,),
           Text("${op}", style: TextStyle(color: Colors.orange, fontSize: 90),),
           SizedBox(width: 10,),
           Text("${num2}", style: TextStyle(color: Colors.orange, fontSize: 90)),
         ],
        ],
      ),
      SizedBox(height: 30,),
      TextButton(
        child: Text("OBTER RESULTADO", style: TextStyle(color: Colors.yellowAccent),),
        onPressed: () {
          setState(() {
            shouldShowResult = !shouldShowResult;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (shouldShowResult) ...[
            Text("${result.toInt()}", style: TextStyle(color: Colors.orange, fontSize: 90)),
          ],
        ],
      ),
      ],
    );
  }
}
