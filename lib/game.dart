import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

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

  late SerialPort myPort;

  late num guessedValue = -1;

  late int streakCounter = 0;

  @override
  void initState() {
    super.initState();
      List<String> availablePorts = SerialPort.availablePorts;
      if (availablePorts.isNotEmpty) {
        print("availablePorts: ${availablePorts}");
        myPort = SerialPort(availablePorts[0]);
        myPort.openReadWrite();
        myPort.config = SerialPortConfig()
          ..baudRate = 9600
          ..bits = 8
          ..stopBits = 1
          ..parity = SerialPortParity.none
          ..rts = SerialPortRts.flowControl
          ..cts = SerialPortCts.flowControl
          ..dsr = SerialPortDsr.flowControl
          ..dtr = SerialPortDtr.flowControl
          ..setFlowControl(SerialPortFlowControl.rtsCts);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Column(
                    children: [
                      Text("STREAK", style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold)),
                      Text("${streakCounter}", style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )
            ],
          ),
          TextButton(
            child: Text("ESCOLHER OPERAÇÃO", style: TextStyle(color: Colors.yellowAccent),),
            onPressed: () {
              setState(() {
                isOperationSelected = !isOperationSelected;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
        isInitialized ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  getWeightFromSerial(myPort).then((value) {
                    setState(() {
                      guessedValue = value.round();
                      if (guessedValue == result) {
                        streakCounter++;
                      } else {
                        streakCounter = 0;
                      }
                    });
                  },);
              },
                icon: Icon(Icons.question_mark_rounded, size: 45, color: Colors.blue,)
            ),
            guessedValue != -1 ? Text("${guessedValue}", style: TextStyle(fontSize: 45, color:  Colors.blueAccent),) : SizedBox()
          ],
        ) : SizedBox(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (shouldShowResult) ...[
              Text("${result.toInt()}", style: TextStyle(color: Colors.orange, fontSize: 90)),
              SizedBox(width: 45,),
              guessedValue == result ?
              Text("ACERTOU", style: TextStyle(fontSize: 90, color: Colors.green),)
                  : Text("ERROU", style: TextStyle(fontSize: 90, color: Colors.red),)
            ],
          ],
        ),
        ],
      ),
    );
  }
}

Future<num> getWeightFromSerial(SerialPort port) async {
  SerialPortReader reader = SerialPortReader(port,timeout:3000);
  Stream<List<int>> upcomingData = reader.stream;

  await for (var value in upcomingData) {
    String decodedValue = String.fromCharCodes(value);
    try {
      double converted = double.parse(decodedValue) / 4.5;
      print("converted: ${converted}");
      return converted;
    } catch (e) {
    }
  }

  return -1;
}