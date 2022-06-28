// import 'package:tapp/models/tapp.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tapp/screens/home/tapp_tile.dart';

// class TappList extends StatefulWidget {
//   @override
//   _TappListState createState() => _TappListState();
// }

// class _TappListState extends State<TappList> {
//   @override
//   Widget build(BuildContext context) {

//     final tapps = Provider.of<List<Tapp>>(context);
//     tapps.forEach((tapp) {
//       print(tapp.user_name);
//       print(tapp.user_password);
//     });

//     return ListView.builder(
//       itemCount: tapps.length,
//       itemBuilder: (context, index) {
//         return TappTile(tapp: tapps[index]);
//       },
//     );
//   }
// }