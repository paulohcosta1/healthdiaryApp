import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthdiary/pages/comments_page.dart';

import 'detail_screen.dart';

class MealTile extends StatelessWidget {
  final DocumentSnapshot meal;
  MealTile(this.meal);

  @override
  Widget build(BuildContext context) {
    var stars = meal['rating'] != null ? meal['rating'] : 0;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
          child: ExpansionTile(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailScreen(meal.data["images"][0]);
            }));
          },
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(meal.data["images"][0]),
            backgroundColor: Colors.white,
          ),
        ),
        title: Text(
          meal.data['type'],
          style:
              TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
        ),
        children: <Widget>[
          Container(
            child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentPage(this.meal.documentID),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                    )
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return index < stars
                        ? Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : Icon(Icons.star_border, color: Colors.grey.shade400);
                  }),
                )),
          )
        ],
      )),
    );
  }
}
