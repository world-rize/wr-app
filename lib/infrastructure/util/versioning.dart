import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

extension StoreEx on FirebaseFirestore {
  /// example: version('v1').collection('users')
  DocumentReference version(String version) =>
      collection('versions').doc(version);

  DocumentReference get latest => collection('versions').doc('v0');
}
