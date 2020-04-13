import 'package:flutter/material.dart';

class CommentModel {
  final String user;
  final String comment;

  const CommentModel({
    @required this.user,
    @required this.comment,
  });
}
