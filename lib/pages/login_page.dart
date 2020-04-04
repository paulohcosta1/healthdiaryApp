import 'package:flutter/material.dart';
import 'package:healthdiary/blocs/login_bloc.dart';
import 'package:healthdiary/pages/client/home_page_client.dart';
import 'package:healthdiary/pages/admin/home_page_admin.dart';
import 'package:healthdiary/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePageAdmin()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("Você não possui os privilégios necessários"),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
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
                            hint: "Usuário",
                            obscure: false,
                            stream: _loginBloc.outUser,
                            onChanged: _loginBloc.changeUser,
                          ),
                          InputField(
                            icon: Icons.lock_outline,
                            hint: "Senha",
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.pinkAccent,
                                    child: Text("Entrar"),
                                    onPressed: snapshot.hasData
                                        ? _loginBloc.submit
                                        : null,
                                    textColor: Colors.white,
                                    disabledColor:
                                        Colors.pinkAccent.withAlpha(140),
                                  ),
                                );
                              })
                        ],
                      ),
                    )),
                  ],
                );
            }
          }),
    );
  }
}
