import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {

  String titleHeader = "Bem-vindo ao jogo do Material Dourado!\n";
  String message = "1. Escolha a operação matemática desejada\n"
      "2. Escolha a dificuldade\n"
      "3. Tente acertar a operação colocando as peças do Material Dourado na balança!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body:
        Center(
          child:
            Column(
              children: [
                SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                ),
                SizedBox(height: 250,),
                Center(
                  child: Text("${titleHeader}", style: TextStyle(color: Colors.yellow, fontSize: 40),),
                ),
                Center(
                  child: Text("${message}", style: TextStyle(color: Colors.yellow, fontSize: 30),),
                )
              ],
            ),
        ),
    );
  }
}
