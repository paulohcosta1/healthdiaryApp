import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthdiary/utils/onesignal_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealBloc extends BlocBase {
  final _dataControler = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();

  Map<String, dynamic> unsavedData = {
    "title": null,
    "images": [],
    "type": null,
  };

  Stream<Map> get outData => _dataControler.stream;
  Stream<bool> get outLoading => _loadingController.stream;

  void saveImages(List images) {
    this.unsavedData["images"] = images;
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveType(String type) {
    unsavedData["type"] = type;
  }

  Future<bool> saveMeal() async {
    _loadingController.add(true);

    sendNotificationAdmin("meal");

    try {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      unsavedData['uid'] = uid;

      DocumentReference dr = await Firestore.instance
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
    StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(uid)
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(unsavedData["images"][0]);

    StorageTaskSnapshot s = await uploadTask.onComplete;
    String downloadUrl = await s.ref.getDownloadURL();

    unsavedData["images"][0] = downloadUrl;
  }

  Future<void> saveRate(double rating, String documentId, String userId) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = rating;

    sendNotification("rating", userId);

    DocumentReference dr =
        await Firestore.instance.collection("meals").document(documentId);

    dr.updateData(data);
  }

  @override
  void dispose() {
    _dataControler.close();
  }
}
