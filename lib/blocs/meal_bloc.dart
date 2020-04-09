import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:healthdiary/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealBloc extends BlocBase {
  final _dataControler = BehaviorSubject<Map>();

  Map unsavedData;

  Stream<Map> get outData => _dataControler.stream;

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  @override
  void dispose() {
    _dataControler.close();
  }
}
