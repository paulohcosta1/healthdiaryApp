import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:healthdiary/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _loginController = BehaviorSubject<String>();
  final _userDataController = BehaviorSubject<Map>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  Stream<String> get outUser => _loginController.stream.transform(validateUser);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;
  Stream<Map> get outUserData => _userDataController.stream;

  Stream<bool> get outSubmitValid =>
      Rx.combineLatest2(outUser, outPassword, (a, b) => true);

  Function(String) get changeUser => _loginController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc() {
    // FirebaseAuth.instance.signOut();
    _streamSubscription =
        FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      if (user != null) {
        if (await verifyPrivileges(user)) {
          _stateController.add(LoginState.SUCCESS);
        } else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit() {
    final user = _loginController.value + "@healthdiary.com.br";
    final password = _passwordController.value;
    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user, password: password)
        .catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(FirebaseUser user) async {
    return await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((doc) {
      if (doc.data != null) {
        _userDataController.add(doc.data);
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }

  @override
  void dispose() {
    _loginController.close();
    _passwordController.close();
    _stateController.close();
    _userDataController.close();
    _streamSubscription.cancel();
  }
}
