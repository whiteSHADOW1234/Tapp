import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapp/models/bus.dart';
import 'package:tapp/models/favorite_bus.dart';
// import 'package:tapp/models/tapper.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });


  final CollectionReference tappCollection = FirebaseFirestore.instance.collection('tappers');

  Future<void> updateUserData(String userAccountName,String userEmail, String userPassword) async {
    return await tappCollection.doc(uid).set({
      'user_account_name': userAccountName,
      'user_email': userEmail,
      'user_password': userPassword,
      'FavoriteBus': [],
      'Groups': [],
    });
  }


  Future<List<dynamic>> getBusList() async {

  return tappCollection.get().then((QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();
    } else {
      return [];
    }
    });
  }




  Future<List<dynamic>> getGroupList() async {
  
  return FirebaseFirestore.instance.collection('tappers').get().then((QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        return doc.data();
      }).toList();
    } else {
      return [];
    }
    });
  }


  
  List <FavoriteBus> _favoriteListFromSnapshot(QuerySnapshot snapshot){
     return snapshot.docs.map((doc){
       return FavoriteBus(
          cityName: doc.get('City Name') ?? '',
          busRoute: doc.get('Bus Route') ?? '',
          busStopName: doc.get('Bus Stop Name') ?? '',
        );
     }).toList();
  }

    Stream<List<FavoriteBus>> get tapps {
    return tappCollection.snapshots()
      .map(_favoriteListFromSnapshot);
  }

  void addFavoriteBus(String busName, String city, String title) {
    tappCollection.doc(uid).update({
      'FavoriteBus': FieldValue.arrayUnion([city + " " + busName + " " + title])
    });

  }

  void deleteFavoriteBus(String title) {
    tappCollection.doc(uid).update({
      'FavoriteBus': FieldValue.arrayRemove([title])
    });
  }


  void addGroupElement(busName, city, String string, int groupIndex) {
    String myData = busName + " " + city + " " + string;
    
    tappCollection.doc(uid).update({
      'Group Stuff.$groupIndex.elements': FieldValue.arrayUnion([myData])
    },);
  }

  void createGroup(String busName, String city, String substring, groupName,int index) {
    tappCollection.doc(uid).update({
      'Group Stuff.$index': {'elements' : [busName + " " + city + " " + substring], 'group name' : groupName}
    },);
  }









// tapp list from snapshot
// List <Tapp> _tappListFromSnapshot(QuerySnapshot snapshot){
//      return snapshot.docs.map((doc){
//        return Tapp(
//          user_account_name: doc.get('user_account_name') ?? '',
//          user_password: doc.get('user_password') ?? '0',
//        );
//      }).toList();
//   }

  // get tapps stream
  // Stream<List<Tapp>> get tapps {
  //   return tappCollection.snapshots()
  //     .map(_tappListFromSnapshot);
  // }

}

