import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:tapp/screens/subpages/bus_result.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tapp/services/database.dart';


String timeText = "No Data yet...";

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class GroupPage extends StatefulWidget {
  dynamic groupStuff;
  int index;
  int allIndex;
  List allgroupData;


  GroupPage({Key? key, required this.groupStuff, required this.index, required this.allIndex, required this.allgroupData}) : super(key: key);
  
  

  @override
  State<GroupPage> createState() => GroupPageState();
}



String displayText = String.fromCharCodes(
    Runes('\u5275' '\u5EFA' '\u6700'  '\u611B' '\u516C''\u8ECA''\u5217''\u8868'':''\n' 
          '1.''\u641C' '\u5C0B' '\u672A''\u4F86' '\u6253' '\u7B97' '\u642D' '\u7684' '\u516C' '\u8ECA' '\n'
          '2.''\u6309' '\u4E0B' '\u516C''\u8ECA' '\u7AD9' '\u724C' '\u65C1' '\u7684' '\u611B' '\u5FC3' '\u6309' '\u9215' '\n'
          '3.''\u9078' '\u64C7' '\u6B32''\u52A0' '\u5165' '\u7684' '\u7FA4' '\u7D44' '\n'
          '4.' '\u56DE' '\u5230' '\u9019' '\u500B' '\u9801' '\u9762'
        )
    );


class GroupPageState extends State<GroupPage> {
    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project   
     // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  

  
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    if(widget.groupStuff['elements'].toString() == '[]'){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.groupStuff['group name'].toString()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.restart_alt_outlined),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.start),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.groupStuff['elements'].length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  title: Text(
                    displayText,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }else{
      print(widget.groupStuff['elements']);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.groupStuff['group name'].toString()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete this group?'),
                      content: Text('If you delete it, you will not be able to see it again.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('Yep~'),
                          onPressed: () {
                            DatabaseService(uid: user.uid).deleteGroup(widget.index, widget.allgroupData);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.restart_alt_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.start),
              onPressed: () {
                for (var i = 0; i < widget.groupStuff['elements'].length; i++) {
                  showNotificationWithoutSound(widget.groupStuff['elements'][i].toString(),i);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.groupStuff['elements'].length,
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

                      // DatabaseService(uid: widget.groupStuff['group name'].toString()).deleteFavoriteBus(widget.groupStuff[index].toString());
                    },
                  ),
                  title: Text(
                    widget.groupStuff['elements'][index].toString(),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }


  Future onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
  

  Future showNotificationWithoutSound(String textstring, int id) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 
        'your channel name', 
        channelDescription: 'your channel description',
        playSound: false, 
        importance: Importance.max, 
        priority: Priority.high
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, 
        iOS: iOSPlatformChannelSpecifics
    );


    String firstString = textstring.split(' ')[0];
    String secondString = textstring.split(' ')[1];
    String thirdString = textstring.split(' ')[2];

    print(firstString);
    print(secondString);
    print(thirdString);


    if(textstring.indexOf('--/') != -1){
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getGoTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    } else {
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getBackTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    }


    // tz.initializeTimeZones();
    // final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    // tz.setLocalLocation(tz.getLocation(currentTimeZone));


    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   id,
    //   '$firstString  ($secondString)',
    //   '$thirdString' + "     " + timeText,
    //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)),
    //   const NotificationDetails(
    //       android: AndroidNotificationDetails(
    //           'your channel id', 
    //           'your channel name',
    //           channelDescription: 'your channel description')
    //       , iOS: IOSNotificationDetails()
    //   ),
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    // );




    
    
    await flutterLocalNotificationsPlugin.show(
      id,
      '$firstString  ($secondString)',
      '$thirdString' + "     " + timeText,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }


  
  Future showrepeatNotificationWithoutSound(String textstring, int id) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 
        'your channel name', 
        channelDescription: 'your channel description',
        playSound: false, 
        importance: Importance.max, 
        priority: Priority.high,
        timeoutAfter: 5000,
        enableLights: true
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, 
        iOS: iOSPlatformChannelSpecifics
    );


    String firstString = textstring.split(' ')[0];
    String secondString = textstring.split(' ')[1];
    String thirdString = textstring.split(' ')[2];

    print(firstString);
    print(secondString);
    print(thirdString);


    if(textstring.indexOf('--/') != -1){
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getGoTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    } else {
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getBackTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    }

    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      '$firstString  ($secondString)',
      '$thirdString' + "     " + timeText,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }



  
  Future showDailyNotificationWithoutSound(String textstring, int id) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 
        'your channel name', 
        channelDescription: 'your channel description',
        playSound: false, 
        importance: Importance.max, 
        priority: Priority.high
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, 
        iOS: iOSPlatformChannelSpecifics
    );


    String firstString = textstring.split(' ')[0];
    String secondString = textstring.split(' ')[1];
    String thirdString = textstring.split(' ')[2];

    print(firstString);
    print(secondString);
    print(thirdString);


    if(textstring.indexOf('--/') != -1){
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getGoTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    } else {
      timeText = await BusInformation(busname: firstString, city: secondString, stopname: thirdString).getBackTime();
      try{
        timeText = (int.parse(timeText)/60).toString()+' min';
      } catch(e) {
        timeText = 'No Data';
      }
    }


    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));


    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      '$firstString  ($secondString)',
      '$thirdString' + "     " + timeText,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 
              'your channel name',
              channelDescription: 'your channel description')
          , iOS: IOSNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }





}




class BusInformation {
  List<String> goTimeData = [];
  List<String> backTimeData = [];

  List<String> goStopNameData=[];
  List<String> backStopNameData=[];

  List<String> goData=[];
  List<String> backData=[];
  String goInfoReturn = '';
  String backInfoReturn = '';
  String City = "";
  String BusName = "";
  String Url = "";
  String busStopUrl = "";
  String stopname = '';

  BusInformation({required String city, required String busname, required String stopname}) {
    City = city;
    BusName = busname;
    this.stopname = stopname;

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
      // print('Go');
      // print(jsonData.length);
      for (var i = 0; i < jsonData.length; i++){
        if (jsonData[i]['Direction']  == 0){
          // print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
          goTimeData.add(jsonData[i]['StopName']['Zh_tw']+"//"+jsonData[i]['EstimateTime'].toString());
        }else{
          // print(jsonData[i]['StopName']['Zh_tw']+" "+jsonData[i]['EstimateTime'].toString());
          backTimeData.add(jsonData[i]['StopName']['Zh_tw']+"///"+ jsonData[i]['EstimateTime'].toString());
        }
      }
    } catch (e) {
      // print('Caught Error: $e');
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
      // print(jsonData[0]['Stops'][0]['StopName']['Zh_tw']);
      // print(jsonData[0]['Stops'].length);
      for(var i = 0; i < jsonData[0]['Stops'].length; i++){
        // print(jsonData[0]['Stops'][i]['StopName']['Zh_tw']);
        goStopNameData.add(jsonData[0]['Stops'][i]['StopName']['Zh_tw']);
      }
      for(var i = 0; i < jsonData[1]['Stops'].length; i++){
        // print(jsonData[1]['Stops'][i]['StopName']['Zh_tw']);
        backStopNameData.add(jsonData[1]['Stops'][i]['StopName']['Zh_tw']);
      }
    } catch (e) {
      // print('Caught Error: $e');
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
          if ('${goStopNameData[i]}' == stopname){
            goInfoReturn = '${goTimeData[j].split("//")[1]}';
            print("${goStopNameData[i]} --// ${goTimeData[j].split("//")[1]}");
          }
          // goData.add("${goStopNameData[i]} --// ${goTimeData[j].split("//")[1]}");
          break;
        }
      }
    }

    for(var i=0; i< backStopNameData.length; i++){
      for (var j = 0; j < backTimeData.length; j++){
        if (backTimeData[j].split("///")[0] == backStopNameData[i]){
          if ('${backStopNameData[i]}' == stopname){
            backInfoReturn = '${backTimeData[j].split("///")[1]}';
            print("${backStopNameData[i]} --// ${backTimeData[j].split("///")[1]}");
          }
          break;
        }
      }
    }
  }
  


  Future<String> getGoTime() async {
    getmergeListData();
    var aimtext = await fetchUserData();
    return '$aimtext';
  }

  Future<String> fetchUserData() => 
    Future.delayed(Duration(seconds: 2), () => goInfoReturn);
    


  Future<String> getBackTime() async{
    getmergeListData();
    var aimtext = await fetchBackData();
    return '$aimtext';
  }

  Future<String> fetchBackData() => 
    Future.delayed(Duration(seconds: 2), () => backInfoReturn);
}



