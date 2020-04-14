import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:healthdiary/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoginState { IDLE, LOADING, SUCCESS, SUCCESS_CLIENT, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outUser => _userController.stream.transform(validateUser);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outUser, outPassword, (a, b) => true);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc() {
    // FirebaseAuth.instance.signOut();
    _streamSubscription =
        FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      // user = null;
      if (user != null) {
        bool isNutritionist = await verifyPrivileges((user));
        if (isNutritionist) {
          _stateController.add(LoginState.SUCCESS);
        } else if (!isNutritionist) {
          _stateController.add(LoginState.SUCCESS_CLIENT);
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
    final user = _userController.value + "@healthdiary.com.br";
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
        .collection("nutricionista")
        .document(user.uid)
        .get()
        .then((doc) {
      if (doc.data != null) {
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
    _userController.close();
    _passwordController.close();
    _stateController.close();

    _streamSubscription.cancel();
  }
}
