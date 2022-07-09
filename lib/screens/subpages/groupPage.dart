import 'package:flutter/material.dart';
import 'package:tapp/services/database.dart';

class GroupPage extends StatefulWidget {
  var groupStuff;

  GroupPage({Key? key, required this.groupStuff}) : super(key: key);
  
  

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupStuff['group name'].toString()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.start),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.groupStuff['elements'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    DatabaseService(uid: widget.groupStuff['group name'].toString()).deleteFavoriteBus(widget.groupStuff[index].toString());
                  },
                ),
                title: Text(
                  widget.groupStuff['elements'][index].toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}