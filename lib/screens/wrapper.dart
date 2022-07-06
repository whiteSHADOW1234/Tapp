import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:tapp/screens/pages/account_info.dart';
import 'package:tapp/screens/pages/chat.dart';
import 'package:tapp/screens/pages/home.dart';
import 'package:tapp/screens/pages/location.dart';
import 'package:tapp/screens/pages/posts.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);
    if (user == null){
      return Authenticate();
    } else {
       return Home();
    //   return MaterialApp(
    //   home: Scaffold(
    //     body: BottomNavigationController(),
    //   ),
    // );
    }
  }
}


class BottomNavigationController extends StatefulWidget {
  // BottomNavigationController({Key key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState extends State<BottomNavigationController> {
  
  int _currentIndex = 0; 
  final pages = [Chat(),Home(),Posts(),Location(), Account()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.whatsapp_rounded,color: Colors.blue,size: 35),label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.blue,size: 35),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.panorama_rounded,color: Colors.blue,size: 35),label: 'Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on,color: Colors.blue,size: 35),label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.blue,size: 35),label: 'Account'),
        ],
        currentIndex: _currentIndex, 
        fixedColor: Colors.amber, 
        onTap: _onItemClick, 
      ),
    );
  }

  
  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}