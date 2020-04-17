import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String nome;
  String role;

  User({this.nome, this.role});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nome = json['nome'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['role'] = this.role;
    return data;
  }
}
