import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  
  bool _isInitialized = false;

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _googleSignIn.initialize();
      _isInitialized = true;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _ensureInitialized();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      
      final List<String> scopes = ['email', 'profile'];
      final clientAuth = await googleUser.authorizationClient.authorizeScopes(scopes);

      final GoogleSignInAuthentication googleAuth =  googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: clientAuth.accessToken, 
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
      
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}