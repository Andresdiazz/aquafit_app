import 'package:aquafitapp/Users/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI{

  final String USERS = "users";

  final Firestore _db = Firestore.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'photo': user.photoUrl,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }
}