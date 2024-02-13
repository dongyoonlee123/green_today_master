import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../consts.dart';

class DayReviewRepository {
  final FirebaseFirestore _storeInstance = FirebaseFirestore.instance;
  late final String _uid;
  final DateFormat dateFormat = DateConst.formatter;

  DayReviewRepository() {
    if (AuthConst.uid == null) {
      _storeInstance.useFirestoreEmulator('localhost', 9099);
      _uid = AuthConst.uid ?? '';
    }
  }

  Future<String?> get(DateTime day) async {
    final dayDocument = await getDayDocument(day).get();
    return dayDocument.get('day_review');
  }

  Future<void> update(DateTime day, String review) async {
    final dayDocRef = getDayDocument(day);
    await dayDocRef.update({'day_review': review});
  }

  CollectionReference getDaysCollection(DateTime date) {
    return _storeInstance
        .collection('users')
        .doc(_uid)
        .collection('events')
        .doc('calendar_events')
        .collection('years')
        .doc('${date.year}')
        .collection('months')
        .doc('${date.month}')
        .collection('days');
  }

  DocumentReference getDayDocument(DateTime date) {
    return getDaysCollection(date).doc(dateFormat.format(date));
  }
}