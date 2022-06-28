// import 'package:tapp/models/tapp.dart';
// import 'package:flutter/material.dart';

// class TappTile extends StatelessWidget {

//   final Tapp tapp;
//   TappTile({ required this.tapp });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: CircleAvatar(
//             radius: 25.0,
//             backgroundColor: Color.fromARGB(255, 113, 66, 48),
//           ),
//           title: Text(tapp.user_name),
//           subtitle: Text(' ${tapp.user_password} '),
//         ),

//       ),
//     );
//   }
// }