import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:tapp/models/bus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var goRunesMessage = Runes('\u5F80');

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class BusApiService {
  List<String> GoData=[];
  List<String> BackData=[];
  String City = "";
  String BusName = "";
  String Url = "";

  BusApiService({required String city, required String busname}) {
    City = city;
    BusName = busname;

    Url = 'https://ptx.transportdata.tw/MOTC/v2/Bus/EstimatedTimeOfArrival/City/$City/$BusName?%24format=JSON';
  }
  
  Future<void> getData() async {
    try {
      int test = 0;
      var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Accept": "application/json",
            "User-Agent": kAndroidUserAgent,
          });
      var jsonData = json.decode(response.body);
      print('Go');
      print(jsonData.length);
      // for (var i = 0; i < jsonData.length; i++){
      //   if (jsonData[i]['Direction'] != '1' && test == 0){
      //     print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
      //     GoData.add(jsonData[i]['StopName']['Zh_tw']+"  "+jsonData[i]['EstimateTime'].toString());
      //   }else{
      //     test = 1;
      //     print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
      //     BackData.add(jsonData[i]['StopName']['Zh_tw']+"  "+ jsonData[i]['EstimateTime'].toString());
      //   }
      // }
      for (var i = 0; i <44; i++) {
        print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
        GoData.add(jsonData[i]['StopName']['Zh_tw']+"  "+jsonData[i]['EstimateTime'].toString());
      }
      print('Back');
      for (var i = 44; i < jsonData.length; i++) {
        print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
        BackData.add(jsonData[i]['StopName']['Zh_tw']+"  "+ jsonData[i]['EstimateTime'].toString());
      }
      print('Done');

    } catch (e) {
      print('Caught Error: $e');
      GoData = ['Could not connect to server...'];
      BackData = ['Could not connect to server...'];
    }
    }
}


class BusPage extends StatefulWidget {
  final Bus bus;
  BusPage({Key? key, required this.bus}) : super(key: key);
  
  get bus_name => bus.busName;
  get city => bus.city;
  get way => bus.way;
  

  @override
  State<BusPage> createState() => _BusPageState();
}
List<String> godata=["Loading..."];
List<String> backdata=["Loading..."];
Color color1 = Colors.grey;
Color color2 = Colors.red;
class _BusPageState extends State<BusPage>  with AutomaticKeepAliveClientMixin<BusPage>{

  setUpBusInfo() async {

    BusApiService instance = BusApiService(city: widget.city, busname: widget.bus_name);

    await instance.getData();
    
    setState(() {
      godata = instance.GoData;
      backdata = instance.BackData;
    });
    
  }
  
  void initState() {
    super.initState();
    setUpBusInfo();
  }

  @override
  Widget build(BuildContext context) {
    var way_sep = widget.way.indexOf(">>>");
    super.build(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text(
                  widget.bus_name,
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: String.fromCharCodes(goRunesMessage) + widget.way.substring(way_sep + 3)),
                Tab(text: String.fromCharCodes(goRunesMessage) + widget.way.substring(0, way_sep)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              godata.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                itemCount: godata.length,
                itemBuilder: (context, index) {
                  var dataAim = godata[index].indexOf("  ");
                  return MyListButton(busName: widget.bus_name, city: widget.city, title: godata[index],seperate: dataAim);
                },
              ),
              backdata.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                itemCount: backdata.length,
                itemBuilder: (context, index) {
                  var dataAim = backdata[index].indexOf("  ");
                  return MyListButton(busName: widget.bus_name, city: widget.city, title: backdata[index],seperate: dataAim);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


class MyListButton extends StatefulWidget {
  final String title;
  final int seperate;
  final String busName;
  final String city;
  MyListButton({Key? key, required this.title, required this.seperate, required this.busName, required this.city}) : super(key: key);
  @override
  _MyListButtonState createState() => _MyListButtonState();
}

class _MyListButtonState extends State<MyListButton> {
   // Default to non pressed
  bool pressAttention = false;
  Color color1 = Colors.grey;
  Color color2 = Colors.red;
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    return Card(
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.favorite,
            color: pressAttention ? color2 : color1,
          ),
          onPressed: () {
            setState(() {
              // DatabaseService(uid: user.uid).addFavoriteBus(widget.busName, widget.city, widget.title.substring(0, widget.seperate+1));
              pressAttention = !pressAttention;
              if (pressAttention) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Groups"),
                      content: GroupList(busName: widget.busName, city: widget.city, title: widget.title.substring(0, widget.seperate+1)),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            pressAttention = !pressAttention;
                            Navigator.of(context).pop();
                          },
                        ),
                        // TextButton(
                        //   child: Text("OK"),
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        // ),
                      ],
                    );
                  },
                );
              }
            });
          },
        ),
        title: Text(
            widget.title.substring(0,widget.seperate+1),
            style: const TextStyle(fontSize: 20),
          ),
          trailing: Text(
            widget.title.substring(widget.seperate+1) == "" ? "No Data" : widget.title.substring(widget.seperate+1),
            style: const TextStyle(fontSize: 20),
          ),
      ),
    );
  }
}



class GroupList extends StatefulWidget {
  final String title;
  final String busName;
  final String city;
  const GroupList({Key? key, required this.title, required this.busName, required this.city}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);

    return FutureBuilder<dynamic>(
      future: DatabaseService(uid: user.uid).getGroupList(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Map<dynamic, dynamic> map = snapshot.data[index];
                // final groupStuff = map.toList();
                return ListTile(
                  // title: Column(
                  //   children: groupStuff.map((group) {
                  //     return Text(group.toString());
                  //   }).toList()),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      // DatabaseService(uid: user.uid).addGroupElement(widget.busName, widget.city, widget.title.toString());
                      print(map["Group Stuff"]);
                      Navigator.pop(context);
                    },
                  )
                );
                // return snapshot.data[index] == null ? const Center(child: Text('Create an Group')) : ListView.builder(
                //   itemCount: snapshot.data[index].length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(snapshot.data[index]),
                //     );
                //   },
                // );
              },
            ),
          );
        }
      },
      );
    
  }
}


