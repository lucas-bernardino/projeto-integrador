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
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,//<--- add this
                image: AssetImage('assets/background.jpg'),
              )),
          child: Center(
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
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.yellow[900],
                        borderRadius: BorderRadius.circular(20), // Adjust the radius for roundness
                      ),
                      child: Text(
                        "${titleHeader}",
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10), // Adjust padding as needed
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.yellow[900],
                        borderRadius: BorderRadius.circular(20), // Adjust the radius for roundness
                      ),
                      child: Text(
                        "${message}",
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ),
        ),
    );
  }
}
