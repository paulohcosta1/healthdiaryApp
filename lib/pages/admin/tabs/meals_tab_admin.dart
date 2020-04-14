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
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return MealTileAdmin(snapshot.data.documents[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
