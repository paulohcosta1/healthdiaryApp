import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthdiary/pages/comments_page.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class MealTileAdmin extends StatelessWidget {
  final DocumentSnapshot meal;
  MealTileAdmin(this.meal);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("clientes")
            .where("uid", isEqualTo: meal.data['uid'])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.isNotEmpty) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(meal.data['type'] +
                            ' - ' +
                            "por " +
                            snapshot.data.documents[0].data['nome']),
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DetailScreen(meal.data["images"][0]);
                            }));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          meal.data['title'],
                          style: TextStyle(
                              color: Colors.grey[850],
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              meal.data["images"][0],
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CommentPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.comment),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: RatingBar(
                                    initialRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    glowColor: Colors.red,
                                    itemCount: 5,
                                    itemSize: 20,
                                    unratedColor: Colors.red,
                                    ratingWidget: RatingWidget(
                                      full: Image.asset(
                                        'assets/images/heart.png',
                                      ),
                                      half: Image.asset(
                                        'assets/images/heart_half.png',
                                      ),
                                      empty: Image.asset(
                                        'assets/images/heart_border.png',
                                      ),
                                    ),
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 20,
                    child: Shimmer.fromColors(
                        child: Container(
                          color: Colors.white.withAlpha(50),
                          margin: EdgeInsets.symmetric(vertical: 4),
                        ),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey),
                  ),
                  SizedBox(
                    width: 50,
                    height: 20,
                    child: Shimmer.fromColors(
                        child: Container(
                          color: Colors.white.withAlpha(50),
                          margin: EdgeInsets.symmetric(vertical: 4),
                        ),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey),
                  )
                ],
              ),
            );
          }
        });
  }
}
