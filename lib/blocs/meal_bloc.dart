import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthdiary/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealBloc extends BlocBase {
  final _dataControler = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();

  Map<String, dynamic> unsavedData = {
    "title": null,
    "images": [],
  };

  Stream<Map> get outData => _dataControler.stream;
  Stream<bool> get outLoading => _loadingController.stream;

  void saveImages(List images) {
    this.unsavedData["images"] = images;
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  Future<bool> saveMeal() async {
    _loadingController.add(true);

    try {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();

      DocumentReference dr = await Firestore.instance
          .collection("clientes")
          .document(uid)
          .collection("meals")
          .add(Map.from(unsavedData)..remove("images"));
      await _uploadImages(uid);
      await dr.updateData(unsavedData);

      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String uid) async {
    print("aaaaaaaaaaaaaaa " + uid);
    StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(uid)
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(unsavedData["images"][0]);

    StorageTaskSnapshot s = await uploadTask.onComplete;
    String downloadUrl = await s.ref.getDownloadURL();

    unsavedData["images"][0] = downloadUrl;
  }

  @override
  void dispose() {
    _dataControler.close();
  }
}
