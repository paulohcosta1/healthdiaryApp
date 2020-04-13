import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthdiary/widgets/meal_tile.dart';
import 'package:healthdiary/widgets/meal_tile_admin.dart';

class MealsTabAdmin extends StatefulWidget {
  @override
  _MealsTabAdminState createState() => _MealsTabAdminState();
}

class _MealsTabAdminState extends State<MealsTabAdmin>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("meals").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              print(snapshot.data.documents[index]);
              return MealTileAdmin(snapshot.data.documents[index]);
            },
          );
        });
  }

  Future<String> getUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }

  @override
  bool get wantKeepAlive => true;
}
