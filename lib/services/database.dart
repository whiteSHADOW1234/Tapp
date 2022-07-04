import 'package:cloud_firestore/cloud_firestore.dart';
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
    });
  }


  Future<void> updateFavoriteData(String cityName,String busRoute, String busStopStartName, String busStopEndName) async {
    return await tappCollection.doc(uid).set({
      'City Name': cityName,
      'Bus Route': busRoute,
      'Bus Stop Start Name': busStopStartName,
      'Bus Stop End Name': busStopEndName,
    });
  }


  Future<void> updateGroupData(String groupName,List<String> favoriteIndexsWithOrder) async {
    return await tappCollection.doc(uid).set({
      'Group Name': groupName,
      'Favorite Indexs': favoriteIndexsWithOrder,
    });
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