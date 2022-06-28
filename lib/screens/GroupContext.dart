
import 'package:flutter/material.dart';

class GroupContext extends StatelessWidget {
    final String title;
    final List<Widget> children;
    final String pictures;

  const GroupContext({
    Key? key,
    required this.title,
    required this.pictures,
    required this.children, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.create_rounded,
                size: 26.0,
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                  Icons.where_to_vote_outlined,
                  size: 26.0,
              ),
            )
          ),
        ],
      ),
      body: ListView(
        children: children,
      ),
    );
  }
}


