import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:tapp/models/bus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var goRunesMessage = Runes('\u5F80');
var almostMessage = Runes('\u5373' '\u5C07' '\u5230' '\u7AD9');
var noCarMessage = Runes('\u5C1A' '\u672A' '\u767C' '\u8ECA');
String groupName = '';
int groupIndex = 0;

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class BusApiService {
  List<String> goTimeData = [];
  List<String> backTimeData = [];

  List<String> goStopNameData=[];
  List<String> backStopNameData=[];

  List<String> goData=[];
  List<String> backData=[];
  String City = "";
  String BusName = "";
  String Url = "";
  String busStopUrl = "";

  BusApiService({required String city, required String busname}) {
    City = city;
    BusName = busname;

    Url = 'https://ptx.transportdata.tw/MOTC/v2/Bus/EstimatedTimeOfArrival/City/$City/$BusName?%24format=JSON';
    busStopUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/$City/$BusName?%24format=JSON';
  }
  



  Future<void> getTimeData() async {
    try {
      var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Accept": "application/json",
            "User-Agent": kAndroidUserAgent,
          });
      var jsonData = json.decode(response.body);
      print('Go');
      print(jsonData.length);
      for (var i = 0; i < jsonData.length; i++){
        if (jsonData[i]['Direction']  == 0){
          print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
          goTimeData.add(jsonData[i]['StopName']['Zh_tw']+"//"+jsonData[i]['EstimateTime'].toString());
        }else{
          print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
          backTimeData.add(jsonData[i]['StopName']['Zh_tw']+"///"+ jsonData[i]['EstimateTime'].toString());
        }
      }
    } catch (e) {
      print('Caught Error: $e');
      goTimeData = ['Could not connect to server...'];
      backTimeData = ['Could not connect to server...'];
    }
  }



  Future<void> getBusStopData() async {
    try{
      var response = await http.get(
          Uri.parse(busStopUrl),
          headers: {
            "Accept": "application/json",
            "User-Agent": kAndroidUserAgent,
          });
      var jsonData = json.decode(response.body);
      print(jsonData[0]['Stops'][0]['StopName']['Zh_tw']);
      print(jsonData[0]['Stops'].length);
      for(var i = 0; i < jsonData[0]['Stops'].length; i++){
        print(jsonData[0]['Stops'][i]['StopName']['Zh_tw']);
        goStopNameData.add(jsonData[0]['Stops'][i]['StopName']['Zh_tw']);
      }
      for(var i = 0; i < jsonData[1]['Stops'].length; i++){
        print(jsonData[1]['Stops'][i]['StopName']['Zh_tw']);
        backStopNameData.add(jsonData[1]['Stops'][i]['StopName']['Zh_tw']);
      }
    } catch (e) {
      print('Caught Error: $e');
      goStopNameData = ['...'];
      backStopNameData = ['...'];
    }
  }



  Future<void> getmergeListData() async {
    await getTimeData();
    await getBusStopData();

    for(var i = 0; i < goStopNameData.length; i++){
      for (var j = 0; j < goTimeData.length; j++){
        if (goTimeData[j].split("//")[0] == goStopNameData[i]){
          goData.add("${goStopNameData[i]} --// ${goTimeData[j].split("//")[1]}");
          break;
        }
      }
    }

    for(var i=0; i< backStopNameData.length; i++){
      for (var j = 0; j < backTimeData.length; j++){
        if (backTimeData[j].split("///")[0] == backStopNameData[i]){
          backData.add("${backStopNameData[i]} /// ${backTimeData[j].split("///")[1]}");
          break;
        }
      }
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


List<String> goData=["Loading..."];
List<String> backData=["Loading..."];
Color color1 = Colors.grey;
Color color2 = Colors.red;

class _BusPageState extends State<BusPage>  with AutomaticKeepAliveClientMixin<BusPage>{

  setUpBusInfo() async {

    BusApiService instance = BusApiService(city: widget.city, busname: widget.bus_name);

    await instance.getmergeListData();
    
    setState(() {
      goData = instance.goData;
      backData = instance.backData;
    });
    
  }
  
  void initState() {
    super.initState();
    setUpBusInfo();
  }

  @override
  Widget build(BuildContext context) {
    var waySep = widget.way.indexOf(">>>");
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
                Tab(text: String.fromCharCodes(goRunesMessage) + widget.way.substring(waySep + 3)),
                Tab(text: String.fromCharCodes(goRunesMessage) + widget.way.substring(0, waySep)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              goData.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                itemCount: goData.length,
                itemBuilder: (context, index) {
                  var dataAim = goData[index].indexOf("//");
                  return MyListButton(busName: widget.bus_name, city: widget.city, title: goData[index],seperate: dataAim);
                },
              ),
              backData.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                itemCount: backData.length,
                itemBuilder: (context, index) {
                  var dataAim = backData[index].indexOf("///");
                  return MyListButton(busName: widget.bus_name, city: widget.city, title: backData[index],seperate: dataAim);
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
    String busTime = "Loading...";
    // print(widget.title + "......" + widget.title.substring(widget.seperate+3));
    try{
      var timeInt = int.parse(widget.title.substring(widget.seperate+3));
      assert(timeInt is int);
      if(timeInt < 60){
        busTime = String.fromCharCodes(almostMessage);
      }else{
        busTime = "${(timeInt/60).toStringAsFixed(0)}min";
      }
    } catch (e) {
      busTime = String.fromCharCodes(noCarMessage);
    }
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
              pressAttention = !pressAttention;
              if (pressAttention) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Your Groups"),
                      content: GroupList(busName: widget.busName, city: widget.city, title: widget.title.substring(0, widget.seperate+1),),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Add a Group Name"),
                                  content: TextField(
                                    decoration: const InputDecoration(
                                      labelText: "Group Name",
                                    ),
                                    onChanged: (value) {
                                      groupName = value;
                                    },
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Add"),
                                      onPressed: () {
                                        DatabaseService(uid: user.uid).createGroup(widget.busName, widget.city, widget.title.substring(0, widget.seperate+1), groupName, groupIndex);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            setState(() {pressAttention = !pressAttention;});
                            Navigator.of(context).pop();
                          },
                        ),
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
            busTime,
            // widget.title.substring(widget.seperate+3) == "" ? "No Data" : (widget.title.substring(widget.seperate+3)),
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
                LinkedHashMap<dynamic, dynamic> map2 = map['Group Stuff'];
                List<dynamic> groupStuff = map2.values.toList();
                return GroupTile(groupStuff: groupStuff, busName:widget.busName, city:widget.city, title: widget.title.toString());
              },
            ),
          );
        }
      },
      );
    
  }
}


class GroupTile extends StatefulWidget {
  final List<dynamic> groupStuff;
  final String busName;
  final String city;
  final String title;
  const GroupTile({Key? key, required this.groupStuff, required this.busName,required this.city,required this.title}) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.groupStuff.length,
      itemBuilder: (context, index) {
        groupIndex = index+1;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(widget.groupStuff[index]['group name'].toString()),
            leading: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                DatabaseService(uid: user.uid).addGroupElement(
                  widget.busName,
                  widget.city,
                  widget.title,
                  index,
                );
                print(widget.groupStuff[index]);
                Navigator.pop(context);
              },
            ),
          ),
        );
      }
    );
  }
}

