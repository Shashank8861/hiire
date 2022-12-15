import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HiireFirebaseUser {
  HiireFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

HiireFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HiireFirebaseUser> hiireFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HiireFirebaseUser>(
      (user) {
        currentUser = HiireFirebaseUser(user);
        return currentUser!;
      },
    );
