import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String url;

  DetailScreen(this.url);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            widget.url,
          ),
        ),
      ),
    );
  }
}
