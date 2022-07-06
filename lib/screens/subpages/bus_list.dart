import 'package:cloud_firestore/cloud_firestore.dart';
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
      // initialData: [],
      future: DatabaseService(uid: user.uid).getBusList(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return BusTile(favoriteBus: snapshot.data[index]['FavoriteBus']);
              // return ListTile(
                // leading: IconButton(
                //   icon: Icon(
                //     Icons.favorite,
                //     color: Colors.red,
                //   ),
                //   onPressed: () {
                //     color: Colors.grey;
                //     DatabaseService(uid: user.uid).deleteFavoriteBus(snapshot.data[index].toString());
                //   },
                // ),
              //   title: Text(
              //     snapshot.data[index]['FavoriteBus'].toString(),
              //   ),
              // );
            },
          );
        }
      },
      );

    // return ListView.builder(
    //   itemCount: buses.length,
    //   itemBuilder: (context, index) {
    //     // return BusTile(favorite_bus: buses[index],);
    //     return ListTile(
    //       title: Text(buses[index].busStopName),
    //       subtitle: Text(buses[index].busRoute),
    //       trailing: IconButton(
    //         icon: Icon(Icons.delete),
    //         onPressed: () {
    //           buses.removeAt(index);
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}


class BusTile extends StatefulWidget {

  final List favoriteBus;
  BusTile({required this.favoriteBus});

  @override
  State<BusTile> createState() => _BusTileState();
}

class _BusTileState extends State<BusTile> {
  String displayText = '';


  bool pressAttention = false;

  Color color1 = Colors.grey;

  Color color2 = Colors.red;

  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
      if(widget.favoriteBus.isNotEmpty){
        // use ListView.builder to display the list of favorite bus
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.favoriteBus.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(
                icon: Icon(
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
            );
          },
        );
      } else{
        String displayText = "Create your favorite bus first\n1. Search your favorite bus stop\n2. Click the heart icon to add it to your favorite bus list \n3.Look them here";
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              title: Center(
                child: Text(
                  displayText,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        );
      }
    
    // String displayText = "";
    // if (widget.favoriteBus.length > 3) {
    //   displayText = widget.favoriteBus.substring(1, widget.favoriteBus.length - 1);
    //   return Padding(
    //     padding: const EdgeInsets.only(top: 8.0),
    //     child: Card(
    //       margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
    //       child: ListTile(
    //         leading: IconButton(
    //                 icon: Icon(
    //                   Icons.favorite,
    //                   color: pressAttention ? color1 : color2,
    //                 ),
    //                 onPressed: () {
    //                   setState(() {pressAttention = !pressAttention;
    //                   DatabaseService(uid: user.uid).deleteFavoriteBus(widget.favoriteBus.substring(1, widget.favoriteBus.length - 1));});
    //                   print(widget.favoriteBus);
    //                 },
    //               ),
    //         title: Text(
    //           displayText,
    //           style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300 ),
    //           ),
    //       ),
    //     ),
    //   );
    // }else {
      // displayText = "Create your favorite bus first\n1. Search your favorite bus stop\n2. Click the heart icon to add it to your favorite bus list \n3.Look them here";
      // return Padding(
      //   padding: const EdgeInsets.only(top: 8.0),
      //   child: Card(
      //     margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      //     child: ListTile(
      //       title: Center(
      //         child: Text(
      //           displayText,
      //           style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    // }
  }
}