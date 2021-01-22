import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuth =
        await _signInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _signInAuth.idToken,
      accessToken: _signInAuth.accessToken,
    );

    var authResult = await firebaseAuth.signInWithCredential(credential);

    User user = authResult.user;
    return user;
  }
}
