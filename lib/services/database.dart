import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapp/models/bus.dart';
import 'package:tapp/models/favorite_bus.dart';
// import 'package:tapp/models/tapper.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
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
  var firestore = FirebaseFirestore.instance;

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

  // void addGroupBus(String groupName, String title) {
  //   tappCollection.doc(uid).update({
  //     'Groups': FieldValue.arrayUnion([groupName + "//" + title])
  //   });

  // }

  void deleteGroup(String groupName) {}

  void addGroupElement(busName, city, String string) {
    // List<Map<String, String>> myData = [{'Elements' : busName + " " + city + " " + string, 'Group Name' : groupName}];
    // String myData = busName + " " + city + " " + string;
    String myData = busName + " " + city + " " + string;
    tappCollection.doc(uid).update({
      'Group Stuff.0.elements': FieldValue.arrayUnion([myData])
    
      // 'Group Stuff.1.Elements': FieldValue.arrayUnion(([myData]))
    },);
  }


  // void deleteGroupBus(String title) {
  //   tappCollection.doc(uid).update({
  //     'Groups': FieldValue.arrayRemove([title])
  //   });
  // }







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

class Group {
  final String groupName;
  final List<String> favoriteIndexsWithOrder;
  Group({ required this.groupName, required this.favoriteIndexsWithOrder });
}