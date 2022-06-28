import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tapp/screens/GroupContext.dart';

class UserGroup extends StatelessWidget {
  final String title;
  final String pictures;
  final List<Widget> children;

  const UserGroup({
    Key? key,
    required this.title,
    required this.pictures,
    required this.children, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          // decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(pictures),
          //   fit: BoxFit.cover,
          //   // alignment: Alignment.topCenter,
          //   ),
          // ),
          child:ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GroupContext(title: title, pictures: pictures, children: children),),);
                },
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Text(
                    '\n\n$title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}