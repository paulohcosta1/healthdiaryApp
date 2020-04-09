import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:healthdiary/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealBloc extends BlocBase {
  final _imageController = BehaviorSubject<String>();
  final _mealNameController = BehaviorSubject<String>();

  Stream<String> get outMealName => _mealNameController.stream;

  void _setMealName(String name) => _mealNameController.add(name);

  @override
  void dispose() {
    _imageController.close();
    _mealNameController.close();
  }
}
