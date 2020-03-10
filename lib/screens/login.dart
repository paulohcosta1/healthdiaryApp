import "package:flutter/material.dart";
import 'package:healthdiary/blocs/login.dart';
import 'package:healthdiary/widgets/input_field.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {   

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginBloc.outState.listen((state){
        switch(state){
          
          case LoginState.IDLE:            
          case LoginState.LOADING:            
          case LoginState.SUCCESS:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=>HomeScreen())  
            );
            break;
          case LoginState.FAIL:
            showDialog(context: context,builder: (context)=>AlertDialog(
              title: Text("Erro"),
              content:Text("Vc nao tem os previlegios necessarios"),
            ));
            break;
        }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          
          switch(snapshot.data){          
            
            case LoginState.LOADING:
              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),);
            case LoginState.IDLE:             
            case LoginState.SUCCESS:             
            case LoginState.FAIL:
            return Stack(
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
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          InputField(
                            icon: Icons.lock_outline,
                            hint: "Senha",
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          SizedBox(height: 30,),
                          StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: 50,
                                  child: RaisedButton(                  
                                    color: Colors.pinkAccent,
                                    child: Text("Entrar"),
                                    onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                    textColor: Colors.white,
                                    disabledColor: Colors.pinkAccent.withAlpha(140),
                                  ),
                              );
                            }
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ); 
          }          
        }
      ),
    );
  }
}