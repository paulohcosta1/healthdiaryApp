import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthdiary/blocs/meal_bloc.dart';
import 'package:healthdiary/widgets/images_widget.dart';
import 'package:image_picker/image_picker.dart';

class MealPage extends StatefulWidget {
  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  File _file;
  String dropdownValue = 'Café da manhã';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          StreamBuilder<bool>(
              stream: null,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.save),
                  color: Colors.white,
                  onPressed: () => _onSave(),
                );
              }),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Selecione uma refeição",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Container(
            child: _dropDown(),
          ),
        ),
        Center(
          child: Container(
            child: ImagesWidget(
              context: context,
              initialValue: [],
              onSaved: _mealBloc.saveImages,
            ),
            width: 250,
          ),
        )
      ],
    );
  }

  void _onSave() {}

  Widget _dropDown() {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      hint: Text("Selecione um tipo de refeição"),
      isExpanded: true,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.pinkAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Café da manhã', 'Almoço', 'Lanche', 'Janta']
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
