import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthdiary/widgets/meal_tile.dart';

class MealsTab extends StatefulWidget {
  final String uid;

  MealsTab(this.uid);

  @override
  _MealsTabState createState() => _MealsTabState();
}

class _MealsTabState extends State<MealsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("clientes")
            .document(widget.uid)
            .collection("meals")
            .snapshots(),
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
              return MealTile(snapshot.data.documents[index]);
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
