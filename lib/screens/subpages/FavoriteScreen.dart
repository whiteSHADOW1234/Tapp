import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/favorite_bus.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/screens/subpages/bus_list.dart';
import 'package:tapp/services/auth.dart';
import 'package:tapp/services/database.dart';

var titleRunesMessage = Runes('\u6211' + '\u7684' +'\u6700' + '\u611B');

class FavoritePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    return StreamProvider<List<FavoriteBus>>.value(
      catchError: (_, __) =>  [],
      value: DatabaseService(uid: user.uid).tapps,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Favorite Bus List'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          // actions: <Widget>[
          //   TextButton.icon(
          //     icon: Icon(Icons.person),
          //     label: Text('logout'),
          //     onPressed: () async {
          //       await _auth.signOut();
          //     },
          //   ),
          // ],
        ),
        body: BusList(),
      ),
    );
  }
}