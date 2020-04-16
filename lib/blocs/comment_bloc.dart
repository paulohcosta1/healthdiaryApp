import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc extends BlocBase {
  final _commentController = BehaviorSubject<String>();

  Stream<String> get outComment => _commentController.stream;

  void saveComment(String value) {
    _commentController.add(value);
  }

  Future<bool> sendComment(String mealId) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final String userUid = user.uid.toString();
    String userName;

    QuerySnapshot getUserName = await Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: userUid)
        .getDocuments();

    userName = getUserName.documents[0].data['nome'];

    await Firestore.instance
        .collection('meals')
        .document(mealId)
        .collection('comments')
        .document()
        .setData({
      'userName': userName,
      'comment': _commentController.value,
    });
  }

  @override
  void dispose() {
    _commentController.close();
  }
}
