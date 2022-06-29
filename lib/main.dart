import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tapp/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapp/services/auth.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  //  BusRoute().getData();
  //  createBusInfo(bus_name: '644',place: 'Taipei', way: 'lalala >>> ohhhh');
  //  createBusInfo(bus_name: '645',place: 'Taipei', way: 'lalala >>> ohhhh');
   runApp(MyApp());
}


class BusRoute {

  //  String TaipeiUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Taipei?%24format=JSON';
  //  String NewTaipeiUrl ='https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/NewTaipei?%24format=JSON';
  //  String TaoyuanUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Taoyuan?%24format=JSON';
  //  String TaichungUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Taichung?%24format=JSON';
  //  String TainanUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Tainan?%24format=JSON';
  //  String KaohsiungUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Kaohsiung?%24format=JSON';
  // String KeelungUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung?%24format=JSON';
  // String HsinchuUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Hsinchu?%24format=JSON';
  // String HsinchuCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/HsinchuCounty?%24format=JSON';
  // String MiaoliCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/MiaoliCounty?%24format=JSON';
  // String ChanghuaCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/ChanghuaCounty?%24format=JSON';
  // String NantouCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/NantouCounty?%24format=JSON';
  // String YunlinCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/YunlinCounty?%24format=JSON';
  // String ChiayiCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/ChiayiCounty?%24format=JSON';
  // String ChiayiUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Chiayi?%24format=JSON';
  // String PingtungCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/PingtungCounty?%24format=JSON';
  // String YilanCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/YilanCounty?%24format=JSON';
  // String HualienCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/HualienCounty?%24format=JSON';
  // String TaitungCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/TaitungCounty?%24format=JSON';
  // String KinmenCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/KinmenCounty?%24format=JSON';
  String PenghuCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/PenghuCounty?%24format=JSON';
  String LienchiangCountyUrl = 'https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/LienchiangCounty?%24format=JSON';

  
  Future<void> getData() async {


    // //this is for taipei bus route
    // print('Taipei');
    // try {
    //   var response = await http.get(
    //       Uri.parse(TaipeiUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <396; i++) {
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'a'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Taipei" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }




    // //this is the new taipei bus route
    // print("NewTaipeiUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(NewTaipeiUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <613; i++) {
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'b'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"NewTaipei" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }

    
    // print("TaoyuanUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(TaoyuanUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <360; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'c'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Taoyuan" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }


    // print("TaichungUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(TaichungUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <376; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'d'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Taichung" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }

    // print("TainanUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(TainanUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <143; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'e'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Tainan" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("KaohsiungUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(KaohsiungUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <351; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'f'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Kaohsiung" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }


    // print("KeelungUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(KeelungUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <102; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'g'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Keelung" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }


    // print("HsinchuUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(HsinchuUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <26; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'h'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Hsinchu" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }




    // print("HsinchuCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(HsinchuCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <28; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'i'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"HsinchuCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("MiaoliCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(MiaoliCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);

    //       for (var i = 0; i <1; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'j'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"MiaoliCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }





    // print("ChanghuaCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(ChanghuaCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <16; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'k'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"ChanghuaCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("NantouCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(NantouCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <14; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'l'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"NantouCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("YunlinCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(YunlinCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <8; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'m'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"YunlinCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }




    // print("ChiayiCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(ChiayiCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <26; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'n'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"ChiayiCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }




    // print("ChiayiUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(ChiayiUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <3; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'o'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"Chiayi" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }


    // print("PingtungCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(PingtungCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <67; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'p'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"PingtungCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("YilanCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(YilanCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <63; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'q'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"YilanCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("HualienCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(HualienCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <9; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'r'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"HualienCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("TaitungCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(TaitungCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <2; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'s'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"TaitungCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("KinmenCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(KinmenCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <100; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'t'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"KinmenCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("PenghuCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(PenghuCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <15; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'u'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"PenghuCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }



    // print("LienchiangCountyUrl");
    // try {
    //   var response = await http.get(
    //       Uri.parse(LienchiangCountyUrl),
    //       headers: {
    //         "Accept": "application/json",
    //         "User-Agent": kAndroidUserAgent,
    //       });
    //       var jsonData = json.decode(response.body);
    //       for (var i = 0; i <23; i++) {
    //         if (jsonData[i]['RouteMapImageUrl']==null){
    //           jsonData[i]['RouteMapImageUrl']="NULL";
    //         }
    //         if (jsonData[i]['DestinationStopNameZh']==null){
    //           jsonData[i]['DestinationStopNameZh']="NULL";
    //         }
    //         if (jsonData[i]['DepartureStopNameZh']==null){
    //           jsonData[i]['DepartureStopNameZh']="NULL";
    //         }
    //         print(jsonData[i]['RouteName']['Zh_tw']+" "+jsonData[i]['DepartureStopNameZh']+" "+jsonData[i]['DestinationStopNameZh'] + " " + jsonData[i]['RouteMapImageUrl']);
    //         createBusInfo(doc_name:'v'+i.toString(),bus_name: jsonData[i]['RouteName']['Zh_tw'],place:"LienchiangCounty" , way: jsonData[i]['DepartureStopNameZh']+" >>> "+jsonData[i]['DestinationStopNameZh'], route_map_image_Url: jsonData[i]['RouteMapImageUrl']);
    //       }
    //       print('Done');
    // } catch (e) {
    //   print('Caught Error: $e');
    // }




  }
}







Future createBusInfo({ required String doc_name, required String bus_name, required String place, required String way, required String route_map_image_Url}) async {
  await FirebaseFirestore.instance.collection('bus').doc(doc_name).set({
    'Bus_name': bus_name,
    'City': place,
    'Way': way,
    'Route_map_image_Url': route_map_image_Url,
  });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
      catchError: (_, __) => null, 
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 88, 76, 76)),
        home: Wrapper(),
      ),
    );
  }
}