import 'package:aquafitapp/Users/model/user.dart';
import 'package:aquafitapp/Users/repository/auth_repository.dart';
import 'package:aquafitapp/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

  //Flujo de Datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;


  //Casos de uso
  //1. Sign In Google
  Future<FirebaseUser> signInWithGoogle() {
    return _auth_repository.signInGoogle();
  }

  //2. Sign In Email and Password
  Future<FirebaseUser> signInEmail(String email, String password) {
    return _auth_repository.signInFirebase(email, password);
  }

  //3. Sign Out
  void signOut(){
    _auth_repository.signOut();
  }

  //4. Crear cuenta con Email and Password
  Future<FirebaseUser> createAccountEmail(String email, String password) {
    return _auth_repository.createAccount(email, password);
  }

  //5. Registra usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);


  @override
  void dispose() {
    // TODO: implement dispose
  }

}