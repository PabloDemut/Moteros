import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MoterosFirebaseUser {
  MoterosFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MoterosFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MoterosFirebaseUser> moterosFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MoterosFirebaseUser>(
        (user) => currentUser = MoterosFirebaseUser(user));
