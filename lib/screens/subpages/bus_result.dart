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
    // print(jsonData[0]['Stops'][0]['StopName']['Zh_tw']);
    }
}


class BusPage extends StatefulWidget {
  final Bus bus;
  BusPage({Key? key, required this.bus}) : super(key: key);
  
  get bus_name => bus.bus_name;
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
                // Text(
                //   widget.way,
                //   style: const TextStyle(fontSize: 15),
                // ),
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
                  return MyListButton(title: godata[index],seperate: dataAim);
                },
              ),
              backdata.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                itemCount: backdata.length,
                itemBuilder: (context, index) {
                  var dataAim = backdata[index].indexOf("  ");
                  return MyListButton(title: backdata[index],seperate: dataAim);
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
  MyListButton({Key? key, required this.title, required this.seperate}) : super(key: key);
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
              print(widget.title);
            });
          },
        ),
        title: Text(
            widget.title.substring(0,widget.seperate+1),
            style: TextStyle(fontSize: 20),
          ),
          trailing: Text(
            widget.title.substring(widget.seperate+1) == "" ? "No Data" : widget.title.substring(widget.seperate+1),
            style: TextStyle(fontSize: 20),
          ),
      ),
    );
  }
}
