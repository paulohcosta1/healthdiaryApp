import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthdiary/pages/client/mealpage/meal_page.dart';
import 'package:healthdiary/pages/client/tabs/meals_tab.dart';

class HomePageClient extends StatefulWidget {
  @override
  _HomePageClientState createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  PageController _pageController;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: _bottomNavigatorBar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return SpeedDial(
      child: Icon(Icons.add),
      backgroundColor: Colors.pinkAccent,
      overlayOpacity: 0.4,
      overlayColor: Colors.black,
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.camera_alt,
              color: Colors.pinkAccent,
            ),
            backgroundColor: Colors.white,
            label: "Enviar foto do prato",
            labelStyle: TextStyle(fontSize: 14),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MealPage()));
            })
      ],
    );
  }

  _body() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return PageView(
            controller: _pageController,
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            children: <Widget>[
              MealsTab(snapshot.data.uid),
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.green,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
      },
    );
  }

  _bottomNavigatorBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.pinkAccent,
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.white54),
            ),
      ),
      child: BottomNavigationBar(
        currentIndex: _page,
        onTap: (p) {
          _pageController.animateToPage(p,
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Dados"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Início"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text("Evoluções"),
          ),
        ],
      ),
    );
  }
}
