import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapp/models/tapp.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference tappCollection = FirebaseFirestore.instance.collection('tappers');

  Future<void> updateUserData(String user_account_name,String user_email, String user_password) async {
    return await tappCollection.doc(uid).set({
      'user_account_name': user_account_name,
      'user_email': user_email,
      'user_password': user_password,
      // 'strength': strength,
    });
  }

  // brew list from snapshot
// List <Tapp> _tappListFromSnapshot(QuerySnapshot snapshot){
//      return snapshot.docs.map((doc){
//        return Tapp(
//          user_account_name: doc.get('user_account_name') ?? '',
//          user_password: doc.get('user_password') ?? '0',
//        );
//      }).toList();
//   }

  // get brews stream
  // Stream<List<Tapp>> get tapps {
  //   return tappCollection.snapshots()
  //     .map(_tappListFromSnapshot);
  // }

}