import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

void initOneSignal() {
  OneSignal.shared.init("f62b4eb9-c4e2-42de-8e00-22fdf8bc3316", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: true
  });

  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // will be called whenever the subscription changes
    //(ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {
    // will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });

  getUserId();

// For each of the above functions, you can also pass in a
// reference to a function as well:

  void _handleNotificationReceived(OSNotification notification) {}

  void main() {
    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);
  }
}

Future<String> getUserId() async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();

  String onesignalUserId = status.subscriptionStatus.userId;

  final FirebaseUser user = await FirebaseAuth.instance.currentUser();

  final String userUid = user.uid.toString();

  await Firestore.instance.collection('users').document(userUid).updateData({
    'onesignal_id': onesignalUserId,
  });

  return onesignalUserId;
}

void sendNotification(typeMessage, senderId) {
  final appId = DotEnv().env['ONESIGNAL_APPID'];

  Map<String, String> headings;
  Map<String, String> contents;

  switch (typeMessage) {
    case "rating":
      headings = {"en": "Atualização de Status: "};
      contents = {"en": "Seu prato foi avaliado"};
      break;
    default:
  }

  Map body = {
    'app_id': appId,
    "include_player_ids": [senderId],
    'headings': headings,
    'contents': contents
  };

  var data = jsonEncode(body);

  http.post("https://onesignal.com/api/v1/notifications", body: data, headers: {
    "Content-Type": "application/json",
  });
}

void sendNotificationAdmin(typeMessage) async {
  final admin = await Firestore.instance
      .collection('users')
      .where("role", isEqualTo: "admin");
  print("aeeeeeolo");
  print(admin.toString());
}
