import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:tapp/screens/pages/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);
    if (user == null){
      return Authenticate();
    } else {
       return Home();
    }
  }
}
