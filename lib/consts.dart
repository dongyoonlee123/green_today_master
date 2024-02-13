import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AuthConst {
  static String? get uid {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}

class DateConst {
  static DateFormat get formatter {
    return DateFormat('y-M-d');
  }
}