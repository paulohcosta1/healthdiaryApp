import 'package:flutter/material.dart';
import 'package:healthdiary/blocs/comment_bloc.dart';
import 'package:healthdiary/validators/comment_validators.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with CommentValidator {
  bool _isComposing = false;
  final _formKey = GlobalKey<FormState>();

  final _commentBloc = CommentBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentários'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  validator: validateComment,
                  decoration: InputDecoration.collapsed(
                    hintText: "Enviar um comentário",
                  ),
                  onChanged: _commentBloc.saveComment,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendComment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendComment() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      bool success = await _commentBloc.sendComment();
    }
  }
}
