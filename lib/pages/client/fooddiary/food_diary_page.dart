import 'package:flutter/material.dart';
import 'package:healthdiary/widgets/my_drawer.dart';

class FoodDiaryPage extends StatefulWidget {
  @override
  _FoodDiaryPageState createState() => _FoodDiaryPageState();
}

class _FoodDiaryPageState extends State<FoodDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diário alimentar'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
      child: Icon(Icons.camera),
      onPressed: _onCameraPressed,
    );
  }

  _onCameraPressed() async {}
}
