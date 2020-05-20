import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount googleSignInAccount =  await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    AuthResult authResult = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );

    FirebaseUser user = await authResult.user;
    return user;
  }

  Future<FirebaseUser> emailAndPasswordSignIn(String email, String password) async{

    AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

    FirebaseUser user = authResult.user;
    return user;
  }

  Future<FirebaseUser> createAccountEmailAndPassword(String email, String password) async{
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    FirebaseUser user = authResult.user;
    return user;
  }

  void signOut() async {
    await _auth.signOut().then((value) => print("Sesion Cerrada"));
    googleSignIn.signOut();
    print("Sesiones Cerradas");
  }

}