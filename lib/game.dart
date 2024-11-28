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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,//<--- add this
              image: AssetImage('assets/background.jpg'),
            )
        ),
        child: Column(
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
              child: Container(
                padding: EdgeInsets.all(5), // Adjust padding as needed
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(10), // Adjust the radius for roundness
                ),
                child: Text(
                  "ESCOLHER OPERAÇÃO",
                  style: TextStyle(
                    color: Colors.yellow[400],
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  isOperationSelected = !isOperationSelected;
                });
              },
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu(
                  width: 250,
                  label: Text("Escolher operação matemática", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
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
                    label: Text("Selecionar dificuldade", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                    textStyle: TextStyle(fontSize: 20, color: Colors.yellow, fontWeight: FontWeight.bold),
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
              child: Container(
                padding: EdgeInsets.all(5), // Adjust padding as needed
                decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(10), // Adjust the radius for roundness
                ),
                child: Text(
                  "OBTER CONTA",
                  style: TextStyle(
                  color: Colors.yellow[400],
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  ),
                  ),
                ),
              onPressed: () {
                setState(() {
                  if (level.contains("Facil")) {
                    result = 21;
                    while (result > 20 || result <= 1) {
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
                          if ((result % 1) != 0) {
                            result = 0;
                            continue;
                          }
                          break;
                      }
                    }
                  }
                  else {
                    result = 0;
                    while (result <= 1) {
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
                          if ((result % 1) != 0) {
                            result = 0;
                            continue;
                          }
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
               Text("${num1}", style: TextStyle(color: Colors.orange[900], fontSize: 90, fontWeight: FontWeight.bold)),
               Text("${op}", style: TextStyle(color: Colors.orange[900], fontSize: 90, fontWeight: FontWeight.bold),),
               Text("${num2}", style: TextStyle(color: Colors.orange[900], fontSize: 90, fontWeight: FontWeight.bold)),
             ],
            ],
          ),
          isInitialized ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.yellow[400],
                child: IconButton(
                    onPressed: () {
                      getWeightFromSerial(myPort).then((value) {
                        setState(() {
                          guessedValue = value.round();
                        });
                      },);
                  },
                    icon: Icon(Icons.question_mark_rounded, size: 60, color: Colors.yellow[900])
                ),
              ),
              guessedValue != -1 ? Text("${guessedValue}", style: TextStyle(fontSize: 90, color:  Colors.blueAccent, fontWeight: FontWeight.bold),) : SizedBox()
            ],
          ) : SizedBox(),
          SizedBox(height: 30,),
          TextButton(
            child: Container(
              padding: EdgeInsets.all(5), // Adjust padding as needed
              decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(10), // Adjust the radius for roundness
              ),
              child: Text(
                "OBTER RESULTADO",
                style: TextStyle(
                  color: Colors.yellow[400],
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                setState(() {
                  shouldShowResult = !shouldShowResult;
                  if (guessedValue == result) {
                    streakCounter++;
                  } else {
                    streakCounter = 0;
                  }
                });
                Future.delayed(const Duration(seconds: 5)).then((value) {
                  setState(() {
                    shouldShowResult = !shouldShowResult;
                    isInitialized = !isInitialized;
                    guessedValue = -1;
                  });
                });
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (shouldShowResult) ...[
                Text("${result.toInt()}", style: TextStyle(color: Colors.orange[900], fontSize: 90, fontWeight: FontWeight.bold),),
                SizedBox(width: 45,),
                guessedValue == result ?
                Text("ACERTOU", style: TextStyle(fontSize: 90, color: Colors.green, fontWeight: FontWeight.bold),)
                    : Text("ERROU", style: TextStyle(fontSize: 90, color: Colors.red, fontWeight: FontWeight.bold),),
                SizedBox(width: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(result.toInt() ~/ 10, (index) {
                    return Image(
                      width: 120,
                      height: 120,
                      image: AssetImage('assets/dezena.png'),
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(result.toInt() % 10, (index) {
                    return Image(
                      width: 40,
                      height: 40,
                      image: AssetImage('assets/unidade.png'),
                    );
                  }),
                )
              ],
            ],
          ),
          ],
        ),
      ),
    );
  }
}

Future<num> getWeightFromSerial(SerialPort port) async {
  SerialPortReader reader = SerialPortReader(port,timeout:3000);
  Stream<List<int>> upcomingData = reader.stream;
  await for (var value in upcomingData) {
    try {
      String decodedValue = String.fromCharCodes(value);
      double converted = double.parse(decodedValue) / 3.0;
      print("converted: ${converted}");
      return converted;
    } catch (e) {
    }
  }
  return -1;
}