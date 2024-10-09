import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';



class Serial extends StatefulWidget {
  const Serial({super.key});

  @override
  State<Serial> createState() => _SerialState();
}

class _SerialState extends State<Serial> {

  late SerialPort myPort;
  String serialBuffer = "";


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
    return Container(
      height: 200,
      width: 300,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child:
        ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          SerialPortReader reader = SerialPortReader(myPort,timeout:3000);
                          Stream upcomingData = reader.stream;
                          upcomingData.listen((data) {
                            setState(() {
                              serialBuffer+=String.fromCharCodes(data);
                            });
                            print(String.fromCharCodes(data));
                          });
                        },
                        child: Text("Começar transmissão via Serial")
                    ),
                    IconButton(
                        onPressed: () {
                          serialBuffer = "";
                        },
                        icon: Icon(Icons.delete, color: Colors.red)
                    ),
                  ],
                ),
                Text("${serialBuffer}", style: TextStyle(color: Colors.white),),
              ],
            )
          ],
        ),
    );
  }
}
