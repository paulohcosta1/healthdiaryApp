import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthdiary/blocs/meal_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MealPage extends StatefulWidget {
  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  File _file;
  String dropdownValue = 'Selecione';

  final _mealBloc = MealBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mealBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: () => _onSave(),
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.camera),
          onPressed: () => _onClickCamera()),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: <Widget>[
          Container(
            child: _DropDown(),
          ),
          Container(
            child: Center(
              child: _file != null ? Image.file(_file) : Text('oi'),
            ),
          )
        ],
      ),
    );
  }

  void _onSave() {
    print('salvando');
  }

  Future<void> _onClickCamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );

    if (image != null) {
      setState(() {
        _file = image;
      });
    }
  }

  Widget _DropDown() {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Selecione', 'Café da manhã', 'Almoço', 'Lanche', 'Janta']
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
