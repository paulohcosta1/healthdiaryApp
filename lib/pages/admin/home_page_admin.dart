import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthdiary/pages/admin/tabs/meals_tab_admin.dart';
import 'package:healthdiary/pages/login_page.dart';
import 'package:healthdiary/utils/onesignal_notifications.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController;
  int _page = 1;
  @override
  void initState() {
    super.initState();
    initOneSignal();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//   var teste = OnesignalNotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutricionista'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: _bottomNavigatorBar(),
      body: _body(),
    );
  }

  _body() {
    return SafeArea(
      child: PageView(
        controller: _pageController,
        onPageChanged: (p) {
          setState(() {
            _page = p;
          });
        },
        children: <Widget>[
          MealsTabAdmin(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
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
            title: Text("Clientes"),
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

  @override
  bool get wantKeepAlive => true;
}
