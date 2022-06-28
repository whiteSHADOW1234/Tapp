import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';
import 'package:tapp/models/tabbar_widget.dart';
// import 'package:tapp/models/tapp.dart';
import 'package:tapp/models/tapp_usergroup.dart';
// import 'package:tapp/services/auth.dart';
// import 'package:tapp/services/database.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var SearchText = new Runes('\u641C'+'\u5C0B'+'\u516C'+'\u8ECA'+'\u8DEF'+'\u7DDA');
  var BusRunesMessage = new Runes('\u516C'+'\u8ECA');
  int group = 0;
  // var TrainRunesMessage = new Runes('\u706B'+'\u8ECA');
  // var IntercityBusRunesMessage = new Runes('\u5BA2'+'\u904B');
  // var HighSpeedTrainRunesMessage = new Runes('\u9AD8'+'\u9435');

  // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) => TabBarWidget(
        searchtext: String.fromCharCodes(SearchText),
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.airport_shuttle_rounded),
                const SizedBox(width: 8),
                Text(new String.fromCharCodes(BusRunesMessage)),
              ],
            ),
          ),

          // Tab(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.directions_railway),
          //       const SizedBox(width: 8),
          //       Text(new String.fromCharCodes(TrainRunesMessage)),
          //     ],
          //   ),
          // ),
          // Tab(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.directions_bus_filled_outlined ),
          //       const SizedBox(width: 8),
          //       Text(new String.fromCharCodes(IntercityBusRunesMessage)),
          //     ],
          //   ),
          // ),
          // Tab(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.train_outlined),
          //       const SizedBox(width: 8),
          //       Text(new String.fromCharCodes(HighSpeedTrainRunesMessage)),
          //     ],
          //   ),
          // ),
          // Tab(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.directions_bike),
          //       const SizedBox(width: 8),
          //       Text('UBike'),
          //     ],
          //   ),
          // ),
        
        ],
        children: [
          buildBus(),
          // buildTrain(),
          // buildIntercityBus(),
          // buildHighSpeedTrain(),
          // buildUBike(),
        ],
      );

      Widget buildBus(){
        if (group == 0) {
          return Container(
             child: Center(
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image),
                  Text('No group yet...'),
                ],
               ),
             )
          );
        } else {
          return Container(
            child: Center(
              child: Text('Group: ' + group.toString()),
            ),
          );
        }
      }

      Widget buildGroup() => Center(
        child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: const SizedBox(
            width: 300,
            height: 100,
            child: Text('A card that can be tapped'),
            ),
          ),
        ),
      );  

      Widget buildTrain() => Center(
        child: Column(
          children: [
            Center(
              child: Text('This page is not available yet.'),
            )
          ]
        )
      );
      Widget buildIntercityBus() => Center(
        child: Column(
          children: [
            Center(
              child: Text('This page is not available yet.'),
            )
          ]
        )
      );
      Widget buildHighSpeedTrain() => Center(
        child: Column(
          children: [
            Center(
              child: Text('This page is not available yet.'),
            )
          ]
        )
      );
      Widget buildUBike() => Center(
        child: Column(
          children: [
            Center(
              child: Text('This page is not available yet.'),
            )
          ]
        )
      );
}



// class CustomSearchDelegate extends SearchDelegate {
// // Demo list to show querying
//   List<String> searchTerms = [
//     "Apple",
//     "Banana",
//     "Mango",
//     "Pear",
//     "Watermelons",
//     "Blueberries",
//     "Pineapples",
//     "Strawberries"
//   ];
	
// // first overwrite to
// // clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//     IconButton(
//       onPressed: () {
//       query = '';
//       },
//       icon: Icon(Icons.clear),
//     ),
//     ];
//   }

// // second overwrite to pop out of search menu
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//     onPressed: () {
//       close(context, null);
//     },
//     icon: Icon(Icons.arrow_back),
//     );
//   }

// // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result), 
//         );
//       },
//     );
//   }

// // last overwrite to show the
// // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//     if (fruit.toLowerCase().contains(query.toLowerCase())) {
//       matchQuery.add(fruit);
//     }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }