import 'package:flutter/material.dart';
import 'package:healthdiary/utils/time_formatter.dart';

class CommentTile extends StatelessWidget {
  Map data;

  CommentTile(this.data);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(data['time'].toDate().toString());
    data['time'] = date.toUtc().millisecondsSinceEpoch;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['userName'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      data['comment'],
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(formatTime(data['time'])),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
