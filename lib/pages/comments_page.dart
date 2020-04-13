import 'package:flutter/material.dart';
import 'package:healthdiary/models/comment.dart';

class CommentsListKeyPrefix {
  static final String singleComment = "Comment";
  static final String commentUser = "Comment User";
  static final String commentText = "Comment Text";
  static final String commentDivider = "Comment Divider";
}

class CommentsList extends StatelessWidget {
  const CommentsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CommentModel> comments = {"teste", "teste", "teste"};

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.comment),
        trailing: Text(comments.length.toString()),
        title: Text("Comments"),
        children: List<Widget>.generate(
          comments.length,
          (int index) => _SingleComment(
            index: index,
          ),
        ),
      ),
    );
  }
}

class _SingleComment extends StatelessWidget {
  final int index;

  const _SingleComment({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'teste',
            textAlign: TextAlign.left,
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
