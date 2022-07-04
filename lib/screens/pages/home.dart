import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tapp/models/bus.dart';
import 'package:tapp/screens/subpages/FavoriteScreen.dart';
import 'package:tapp/screens/subpages/bus_result.dart';

var titleRunesMessage = Runes('\u6211' + '\u7684' +'\u6700' + '\u611B');
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
              child: BackGroundView(
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
                      } else if (filteredSearchHistory.isNotEmpty && controller.query.isEmpty) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: filteredSearchHistory
                              .map(
                                (term) => ListTile(
                                  title: Text(
                                    term,
                                    maxLines: 1,
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
                      } else {
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
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => BusPage(
                                            bus: Bus(bus_name: '${doc.get('Bus_name')}', way: '${doc.get('Way')}', city: '${doc.get('City')}'),
                                          ),
                                        ),
                                      );
                                    }
                                  )
                              ],
                            );
                          }
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




class BackGroundView extends StatelessWidget {
  final String searchTerm;

  const BackGroundView({
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
            // if (group == 0) {
              return Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        //change to favorite screen 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 100,
                              width: 450,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("asset/mount.jpg"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              child: Center(
                                child: Text(String.fromCharCodes(titleRunesMessage),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  )
                
                // child: Text(
                //   'Search your favorite bus \nand create a group now',
                //   style: Theme.of(context).textTheme.headline6,
                // ),
              );
            // } else {
            //   return ListView(
            //     shrinkWrap: true,
            //     children: [
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
            //     ],
            //   );
            // }
         }
       )
    );
  }
}
