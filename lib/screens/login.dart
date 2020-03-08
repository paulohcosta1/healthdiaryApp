import "package:flutter/material.dart";
import 'package:healthdiary/widgets/input_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.free_breakfast,
                    color: Colors.pinkAccent,
                    size: 160,
                    ),
                    InputField(
                      icon: Icons.person_outline,
                      hint: "Usuario",
                      obscure: false,
                    ),
                    InputField(
                      icon: Icons.lock_outline,
                      hint: "Senha",
                      obscure: true,
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                        child: RaisedButton(                  
                          color: Colors.pinkAccent,
                          child: Text("Entrar"),
                          onPressed: (){},
                          textColor: Colors.white,
                        ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}