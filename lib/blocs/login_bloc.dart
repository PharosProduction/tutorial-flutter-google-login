import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  // StreamController
  final BehaviorSubject<GoogleSignInAccount> _google = BehaviorSubject<GoogleSignInAccount>();

  // Streams

  Stream<GoogleSignInAccount> get googleAccount => _google.stream;

  sigInGoogle() async {
    _googleSignIn.signIn().then((GoogleSignInAccount account) {
      _google.sink.add(account);
    });
  }

  signOutGoogle() async {
    _googleSignIn.signOut().then(_google.sink.add);
  }

  dispose() {
    _google.close();
  }
}
