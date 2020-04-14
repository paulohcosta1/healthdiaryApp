import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc extends BlocBase {
  final _commentController = BehaviorSubject<String>();
  String comment = "";

  void saveComment(String value) {
    comment = value;
    print(comment);
  }

  Future<bool> sendComment() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
