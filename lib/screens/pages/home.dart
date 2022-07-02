import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class GetData { 
  final String bus_name, city, way;
   GetData({required this.bus_name, required this.city, required this.way});
}

  CollectionReference _busRoutes = FirebaseFirestore.instance.collection('bus');
  var group_items;
class _HomeState extends State<Home> {
  String searchText = String.fromCharCodes(Runes('\u641C'+'\u5C0B'+'\u516C'+'\u8ECA'+'\u8DEF'+'\u7DDA'));
  var busRunesMessage = new Runes('\u516C'+'\u8ECA');
  int group = 0;
  
  String key = '   ';
  // var TrainRunesMessage = new Runes('\u706B'+'\u8ECA');
  // var IntercityBusRunesMessage = new Runes('\u5BA2'+'\u904B');
  // var HighSpeedTrainRunesMessage = new Runes('\u9AD8'+'\u9435');

  // final AuthService _auth = AuthService();

  List<GetData> _getDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return GetData(
        bus_name: doc.get('Bus_name') ?? '',
        city: doc.get('City') ?? '',
        way: doc.get('Way') ?? '',
      );
    }).toList();
  }




  static const historyLength = 5;

  List<String> _searchHistory = [];

  late List<String> filteredSearchHistory;

  late String selectedTerm = searchText;

  List<String> filterSearchTerms({required String filter,}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);

    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }



  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: FloatingSearchBar(
            height: 40,
            width: 370,
            controller: controller,
            body: FloatingSearchBarScrollNotifier(
              child: SearchResultsListView(
                searchTerm: selectedTerm,
              ),
            ),
            transition: CircularFloatingSearchBarTransition(),
            physics: BouncingScrollPhysics(),
            title: Text(
              selectedTerm,
              style: Theme.of(context).textTheme.headline6,
            ),
            hint: searchText,
            actions: [
              FloatingSearchBarAction.searchToClear(),
            ],
            onQueryChanged: (query) {
              setState(() {key = query;});
              // print(query);
            },
            onSubmitted: (query) {
              setState(() {
                addSearchTerm(query);
                selectedTerm = query;
              });
              controller.close();
            },
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4,
                  child: Builder(
                    builder: (context) {
                      if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                        return Container(
                          height: 56,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Start searching',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        );
                      } else if (filteredSearchHistory.isEmpty) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: _busRoutes.snapshots().asBroadcastStream(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return ListView(
                                shrinkWrap: true,
                                children: [
                                  Center(
                                    child: Text("Searching..."),
                                  ),
                                ],
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: [
                                for (var doc in snapshot.data!.docs)
                                  if (doc.get('Bus_name').toString().contains(key)) 
                                  InkWell(
                                    child: ListTile(
                                      title: Text(doc.get('Bus_name')),
                                      subtitle: Text(doc.get('Way')),
                                      trailing: Text(doc.get('City')),
                                    ),
                                    onTap: (){
                                      addSearchTerm(doc.get('Bus_name')+'   ('+doc.get('Way')+')');
                                    }
                                  )
                              ],
                            );
                          }
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: filteredSearchHistory
                              .map(
                                (term) => ListTile(
                                  title: Text(
                                    term,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: const Icon(Icons.history),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        deleteSearchTerm(term);
                                      });
                                    },
                                  ),
                                  onTap: () {
                                    setState(() {
                                      putSearchTermFirst(term);
                                      selectedTerm = term;
                                      print(selectedTerm);
                                    });
                                    controller.close();
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}



class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 60,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return Scaffold(
      appBar:AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: 
       Builder(
         builder: (group){
            if (group == 0) {
              return Center(
                child: Text(
                  'No search results',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  // for (var doc in group_items)
                  //   InkWell(
                  //     child: ListTile(
                  //       title: Text(doc.get('Bus_name')),
                  //       subtitle: Text(doc.get('Way')),
                  //       trailing: Text(doc.get('City')),
                  //     ),
                  //     onTap: (){
                  //       // fsb!.addSearchTerm(doc.get('Bus_name'));
                  //     }
                  //   )
                ],
              );
            }
         }

         
       )

    );

    // return ListView(
    //   padding: EdgeInsets.only(top: 10),
    //   children: List.generate(
    //     10,
    //     (index) => ListTile(
    //       title: Text('$searchTerm search result'),
    //       subtitle: Text(index.toString()),
    //     ),
    //   ),
    // );
  }
}











// @override
//   Widget build(BuildContext context){
//     final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//     return MaterialApp(
//       home: Scaffold(
//         body: FloatingSearchBar(
//             hint: 'Search...',
//             scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//             transitionDuration: const Duration(milliseconds: 800),
//             transitionCurve: Curves.easeInOut,
//             physics: const BouncingScrollPhysics(),
//             axisAlignment: isPortrait ? 0.0 : -1.0,
//             openAxisAlignment: 0.0,
//             width: isPortrait ? 600 : 500,
//             debounceDelay: const Duration(milliseconds: 500),
//           onQueryChanged: (query) {
//             // Call your model, bloc, controller here.
//           },
//           // Specify a custom transition to be used for
//           // animating between opened and closed stated.
//           transition: CircularFloatingSearchBarTransition(),
//           actions: [
//             FloatingSearchBarAction(
//               showIfOpened: false,
//               child: CircularButton(
//                 icon: const Icon(Icons.favorite),
//                 onPressed: () {
//                   print('this is the place to seee your favorite');
//                 },
//               ),
//             ),
//             FloatingSearchBarAction.searchToClear(
//               showIfClosed: false,
//             ),
//           ],
//           builder: (context, transition) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Material(
//                 color: Colors.white,
//                 elevation: 4.0,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: Colors.accents.map((color) {
//                     return Container(height: 112, color: color);
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



















  // @override
  // Widget build(BuildContext context) => TabBarWidget(
  //       searchtext: String.fromCharCodes(SearchText),
  //       tabs: [
  //         Tab(
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(Icons.airport_shuttle_rounded),
  //               const SizedBox(width: 8),
  //               Text(new String.fromCharCodes(BusRunesMessage)),
  //             ],
  //           ),
  //         ),

  //         // Tab(
  //         //   child: Row(
  //         //     mainAxisSize: MainAxisSize.min,
  //         //     children: [
  //         //       Icon(Icons.directions_railway),
  //         //       const SizedBox(width: 8),
  //         //       Text(new String.fromCharCodes(TrainRunesMessage)),
  //         //     ],
  //         //   ),
  //         // ),
  //         // Tab(
  //         //   child: Row(
  //         //     mainAxisSize: MainAxisSize.min,
  //         //     children: [
  //         //       Icon(Icons.directions_bus_filled_outlined ),
  //         //       const SizedBox(width: 8),
  //         //       Text(new String.fromCharCodes(IntercityBusRunesMessage)),
  //         //     ],
  //         //   ),
  //         // ),
  //         // Tab(
  //         //   child: Row(
  //         //     mainAxisSize: MainAxisSize.min,
  //         //     children: [
  //         //       Icon(Icons.train_outlined),
  //         //       const SizedBox(width: 8),
  //         //       Text(new String.fromCharCodes(HighSpeedTrainRunesMessage)),
  //         //     ],
  //         //   ),
  //         // ),
  //         // Tab(
  //         //   child: Row(
  //         //     mainAxisSize: MainAxisSize.min,
  //         //     children: [
  //         //       Icon(Icons.directions_bike),
  //         //       const SizedBox(width: 8),
  //         //       Text('UBike'),
  //         //     ],
  //         //   ),
  //         // ),
        
  //       ],
  //       children: [
  //         buildBus(),
  //         // buildTrain(),
  //         // buildIntercityBus(),
  //         // buildHighSpeedTrain(),
  //         // buildUBike(),
  //       ],
  //     );












      // Widget buildBus(){
      //   if (group == 0) {
      //     return Container(
      //        child: Center(
      //          child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(Icons.image),
      //             Text('No group yet...'),
      //           ],
      //          ),
      //        )
      //     );
      //   } else {
      //     return Container(
      //       child: Center(
      //         child: Text('Group: ' + group.toString()),
      //       ),
      //     );
      //   }
      // }

      // Widget buildGroup() => Center(
      //   child: Card(
      //   child: InkWell(
      //     splashColor: Colors.blue.withAlpha(30),
      //     onTap: () {
      //       debugPrint('Card tapped.');
      //     },
      //     child: const SizedBox(
      //       width: 300,
      //       height: 100,
      //       child: Text('A card that can be tapped'),
      //       ),
      //     ),
      //   ),
      // );  

      // Widget buildTrain() => Center(
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Text('This page is not available yet.'),
      //       )
      //     ]
      //   )
      // );
      // Widget buildIntercityBus() => Center(
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Text('This page is not available yet.'),
      //       )
      //     ]
      //   )
      // );
      // Widget buildHighSpeedTrain() => Center(
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Text('This page is not available yet.'),
      //       )
      //     ]
      //   )
      // );
      // Widget buildUBike() => Center(
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Text('This page is not available yet.'),
      //       )
      //     ]
      //   )
      // );























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