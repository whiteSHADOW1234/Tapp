import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/bus.dart';
import 'package:tapp/models/user.dart';
// import 'package:tapp/screens/subpages/FavoriteScreen.dart';
import 'package:tapp/screens/subpages/bus_result.dart';
// import 'package:tapp/screens/subpages/createbusgroup.dart';
import 'package:tapp/screens/subpages/groupPage.dart';
import 'package:tapp/services/database.dart';

String titleRunesMessage = String.fromCharCodes(Runes('\u6211'  '\u7684' '\u6700'  '\u611B'));
String grouptitleMessage = String.fromCharCodes(Runes('\u5275' '\u5EFA' '\u516C' '\u8ECA' '\u7FA4' '\u7D44'));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class GetData { 
  final String bus_name, city, way;
   GetData({required this.bus_name, required this.city, required this.way});
}

  CollectionReference _busRoutes = FirebaseFirestore.instance.collection('bus');
  // var group_items;
class _HomeState extends State<Home> {
  String searchText = String.fromCharCodes(Runes('\u641C'+'\u5C0B'+'\u516C'+'\u8ECA'+'\u8DEF'+'\u7DDA'));
  var busRunesMessage = new Runes('\u516C'+'\u8ECA');
  int group = 0;
  
  String key = '   ';
  // var TrainRunesMessage = new Runes('\u706B'+'\u8ECA');
  // var IntercityBusRunesMessage = new Runes('\u5BA2'+'\u904B');
  // var HighSpeedTrainRunesMessage = new Runes('\u9AD8'+'\u9435');

  // final AuthService _auth = AuthService();



  static const historyLength = 5;

  final List<String> _searchHistory = [];

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
            physics: const BouncingScrollPhysics(),
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
                                // scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                // physics: ScrollPhysics(),
                                children: [
                                  Center(
                                    // child: Text("Searching...\n"),
                                    child: LoadingAnimationWidget.staggeredDotsWave(
                                      color: Color.fromARGB(255, 0, 140, 255),
                                      size: 25,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
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
                                      addSearchTerm(doc.get('Bus_name'));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BusPage(
                                            bus: Bus(busName: '${doc.get('Bus_name')}', way: '${doc.get('Way')}', city: '${doc.get('City')}'),
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
            const Icon(
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
    User1 user = Provider.of<User1>(context);

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
      // body: Text(user.uid),
      body: FutureBuilder<dynamic>(
        future: DatabaseService(uid: user.uid).getGroupList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final groupList = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: groupList.length,
            itemBuilder: (context, index) {
              Map<dynamic, dynamic> map = snapshot.data[index];
              LinkedHashMap<dynamic, dynamic> map2 = map['Group Stuff'];
              List<dynamic> groupStuff = map2.values.toList();
              return GroupCard(
                groupStuff: groupStuff,
              );
            },
          );
        },
      ),
    );
  }

}


class GroupCard extends StatefulWidget {
  final List<dynamic> groupStuff;
  const GroupCard({Key? key, required this.groupStuff}) : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}
class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    int allIndex = widget.groupStuff.length;
    User1 user = Provider.of<User1>(context);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.groupStuff.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupPage(
                      allgroupData: widget.groupStuff,
                      groupStuff: widget.groupStuff[index],
                      index: index,
                      allIndex: allIndex,
                    ),
                  ),
                );
              });
            },
            child: Container(
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  width: 450,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 48, 162, 255), Color.fromARGB(255, 33, 243, 201)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.doorbell_rounded,
                          size: 35
                        ),
                        color: Colors.white,
                        onPressed: () {
                          print("pressed");
                        },
                      ),
                      title: Text(
                        widget.groupStuff[index]['group name'].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)
                        )
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}