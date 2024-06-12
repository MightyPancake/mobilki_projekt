// auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '559087557131-6f6qnjk74ab60kr7ha34e3iu03979o7h.apps.googleusercontent.com',
    scopes: ['email'],
  );

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signInSilently();
      if (googleSignInAccount == null) {
        googleSignInAccount = await _googleSignIn.signIn();
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Save user data to Firebase Database
          final DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');
          final DatabaseReference userRef = usersRef.child(user.uid);

          await userRef.set({
            'username': user.displayName,
            'email': user.email,
            // Add more fields as necessary
          });

          return user;
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
    return null;
  }
}
