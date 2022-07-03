import 'package:flutter/material.dart';
import 'package:tapp/models/bus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
// class SendBusResult{
//   List<String> goData=[];
//   List<String> backData=[];
//   SendBusResult({required this.goData,required this.backData});
//   // List<String> goBusStop = [];
//   // List<String> goTimeout = [];
//   // List<String> backBusStop = [];
//   // List<String> backTimeout = [];
//   // SendBusResult({required this.goBusStop,required this.goTimeout,required this.backBusStop,required this.backTimeout});
// }
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

      var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Accept": "application/json",
            "User-Agent": kAndroidUserAgent,
          });
              var jsonData = json.decode(response.body);
              print('Go');
              print(Url);
              for (var i = 0; i <44; i++) {
                print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
                GoData.add(jsonData[i]['StopName']['Zh_tw']+"  "+jsonData[i]['EstimateTime'].toString());
              }
              print('Back');
              for (var i = 44; i <88; i++) {
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
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  widget.way,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Go'),
                Tab(text: 'Back'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              godata.length == 0 ? Center(child: Text('No Data')) : ListView.builder(
                itemCount: godata.length,
                itemBuilder: (context, index) {
                  var dataAim = godata[index].indexOf("  ");
                  return MyListButton(title: godata[index],seperate: dataAim);
                  // return Card(
                  //   child: ListTile(
                  //     leading: IconButton(
                  //       icon: Icon(
                  //         Icons.favorite,
                  //         color: color1,
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           if (color1 == Colors.grey) {
                  //             color1 = color2;
                  //           } else {
                  //             color1 = Colors.grey;
                  //           }
                  //         });
                  //       },
                  //     ),
                  //     title: Text(
                  //         godata[index].substring(0,dataAim+1),
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //       trailing: Text(
                  //         godata[index].substring(dataAim+1) == "" ? "No Data" : godata[index].substring(dataAim+1),
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //   ),
                  // );
                },
              ),
              backdata.length == 0 ? Center(child: Text('No Data')) : ListView.builder(
                itemCount: backdata.length,
                itemBuilder: (context, index) {
                  var dataAim = backdata[index].indexOf("  ");
                  return MyListButton(title: backdata[index],seperate: dataAim);
                  // return Card(
                  //   child: ListTile(
                  //     leading: IconButton(
                  //       icon: Icon(
                  //         Icons.favorite,
                  //         color: color1,
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           if (color1 == Colors.grey) {
                  //             color1 = Colors.red;
                  //           } else {
                  //             color1 = Colors.grey;
                  //           }
                  //         });
                  //       },
                  //     ),
                  //     title: Text(
                  //       data[0],
                  //       style: TextStyle(fontSize: 20),
                  //     ),
                  //     trailing: Text(
                  //       data[1],
                  //       style: TextStyle(fontSize: 20),
                  //     ),
                  //   ),
                  // );
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







// class BusPage extends StatelessWidget {
  // final Bus bus;
  // BusPage({Key? key, required this.bus}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 1,
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('TabBar Widget'),
//           bottom: const TabBar(
//             tabs: <Widget>[
//               Tab(
//                 text: 'Go',
//               ),
//               Tab(
//                 text: 'Back',
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: <Widget>[
//             Center(
//               child: Scaffold(
//                 body: BusApiService(city: bus.city, busname: bus.bus_name),
//               ),
//             ),
//             Center(
//               child: Text("It's rainy here"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









