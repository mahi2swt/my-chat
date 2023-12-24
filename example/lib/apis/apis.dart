import 'package:firebase_auth/firebase_auth.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //? Data Stroing for future use ---
  static User get user => auth.currentUser!;
}
