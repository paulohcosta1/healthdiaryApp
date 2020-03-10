import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthdiary/validators/login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

enum LoginState {
  IDLE,
  LOADING,
  SUCCESS,
  FAIL
}

class LoginBloc extends BlocBase with LoginValidators{
  final _emailControler = BehaviorSubject<String>();
  final _passwordControler = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail  => _emailControler.stream.transform(validateEmail);
  Stream<String> get outPassword  => _passwordControler.stream.transform(validatePassword);
  Stream<LoginState> get outState  => _stateController.stream;
  Stream<bool> get outSubmitValid => Observable.combineLatest2(
    outEmail, outPassword, (a,b) => true
  );

  StreamSubscription _streamSubscription;

  LoginBloc(){
    
    _streamSubscription = FirebaseAuth.instance.onAuthStateChanged.listen((user) async{
      if(user != null){
          if(await verifyPrivileges(user)){
            _stateController.add(LoginState.SUCCESS);
          }else{
            FirebaseAuth.instance.signOut();
            _stateController.add(LoginState.FAIL);
          }

      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  
  Function(String) get changeEmail => _emailControler.sink.add;
  Function(String) get changePassword => _passwordControler.sink.add;

  Future<bool> verifyPrivileges(FirebaseUser user) async {
    return await Firestore.instance.collection("admin").document(user.uid).get().then((doc){
      if(doc.data != null){
        return true;
      }else{
        return false;
      }
    }).catchError((e){
      return false;
    });  
  }

 void submit(){
    final email = _emailControler.value;
    final password = _passwordControler.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).catchError((e){
      _stateController.add(LoginState.FAIL);
    });
  }
 
  @override
  void dispose() {
    _emailControler.close();
    _passwordControler.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
  
}