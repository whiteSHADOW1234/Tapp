import 'package:provider/provider.dart';
import 'package:tapp/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapp/services/auth.dart';
import 'models/user.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
      catchError: (_, __) => null, 
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 88, 76, 76)),
        home: Wrapper(),
      ),
    );
  }
}