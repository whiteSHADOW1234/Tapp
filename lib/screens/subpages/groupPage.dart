import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';

class GroupPage extends StatefulWidget {
  dynamic groupStuff;
  int index;
  int allIndex;
  List allgroupData;


  GroupPage({Key? key, required this.groupStuff, required this.index, required this.allIndex, required this.allgroupData}) : super(key: key);
  
  

  @override
  State<GroupPage> createState() => _GroupPageState();
}

String displayText = String.fromCharCodes(
    Runes('\u5275' '\u5EFA' '\u6700'  '\u611B' '\u516C''\u8ECA''\u5217''\u8868'':''\n' 
          '1.''\u641C' '\u5C0B' '\u672A''\u4F86' '\u6253' '\u7B97' '\u642D' '\u7684' '\u516C' '\u8ECA' '\n'
          '2.''\u6309' '\u4E0B' '\u516C''\u8ECA' '\u7AD9' '\u724C' '\u65C1' '\u7684' '\u611B' '\u5FC3' '\u6309' '\u9215' '\n'
          '3.''\u9078' '\u64C7' '\u6B32''\u52A0' '\u5165' '\u7684' '\u7FA4' '\u7D44' '\n'
          '4.' '\u56DE' '\u5230' '\u9019' '\u500B' '\u9801' '\u9762'
        )
    );

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    if(widget.groupStuff['elements'].toString() == '[]'){
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
                  title: Text(
                    displayText,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }else{
      print(widget.groupStuff['elements']);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.groupStuff['group name'].toString()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  DatabaseService(uid: user.uid).deleteGroup(widget.index,  widget.allgroupData);
                  Navigator.pop(context);
                });
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
}