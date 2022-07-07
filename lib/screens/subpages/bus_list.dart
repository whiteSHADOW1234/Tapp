import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/favorite_bus.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';

class BusList extends StatefulWidget {

  @override
  _BusListState createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);

    final buses = Provider.of<List<FavoriteBus>>(context);

    return FutureBuilder<dynamic>(
      future: DatabaseService(uid: user.uid).getBusList(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return BusTile(favoriteBus: snapshot.data[index]['FavoriteBus']);
            },
          );
        }
      },
      );
  }
}


class BusTile extends StatefulWidget {

  final List favoriteBus;
  BusTile({required this.favoriteBus});

  @override
  State<BusTile> createState() => _BusTileState();
}

class _BusTileState extends State<BusTile> {
  String displayText = String.fromCharCodes(
    Runes('\u5275' '\u9020' '\u6700'  '\u611B' '\u516C''\u8ECA''\u5217''\u8868'':''\n' 
          '1.''\u641C' '\u5C0B' '\u672A''\u4F86' '\u6253' '\u7B97' '\u642D' '\u7684' '\u516C' '\u8ECA' '\n'
          '2.''\u6309' '\u4E0B' '\u516C''\u8ECA' '\u7AD9' '\u724C' '\u65C1' '\u7684' '\u611B' '\u5FC3' '\u6309' '\u9215' '\n'
          '3.' '\u56DE' '\u5230' '\u9019' '\u500B' '\u9801' '\u9762'
        )
    );


  bool pressAttention = false;

  Color color1 = Colors.grey;

  Color color2 = Colors.red;

  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
      if(widget.favoriteBus.isNotEmpty){
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.favoriteBus.length,
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
                      color1 = Colors.grey;
                      color2 = Colors.red;
                      DatabaseService(uid: user.uid).deleteFavoriteBus(widget.favoriteBus[index].toString());
                    },
                  ),
                  title: Text(
                    widget.favoriteBus[index].toString(),
                  ),
                ),
              ),
            );
          },
        );
      } else{
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              title: Center(
                child: Text(
                  displayText,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        );
      }
  }
}