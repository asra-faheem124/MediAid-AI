import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaid_ui/model/history_model.dart';
import 'package:mediaid_ui/model/resultModel.dart';
import 'package:uuid/uuid.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference? get _historyRef {
    if (_uid == null) return null;
    return _firestore.collection('User').doc(_uid).collection('History');
  }

  Future<void> saveScan(ResultModel result) async {
    if (_uid == null) return;

    try {
      final id = const Uuid().v4();

      final history = HistoryModel(
        id: id,
        injury: result.injury,
        severity: result.severity,
        decision: result.decision,
        injuryEmoji: result.injuryEmoji,
        confidencePercent: result.confidencePercent,
        goHospital: result.goHospital,
        firstAidSteps: result.firstAidSteps,
        scannedAt: DateTime.now(),
      );

      await _historyRef!.doc(id).set(history.toMap());
      print("Scan saved");
      print("UID: $_uid");
print("Saving to: User/$_uid/History/$id");
    } catch (e) {
      print(e);
    }
  }

  // CHANGED: Stream instead of Future
  Stream<List<HistoryModel>> getHistoryStream() {
    if (_uid == null) return Stream.value([]);

    return _historyRef!
        .orderBy('scannedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                HistoryModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> deleteScan(String id) async {
    if (_uid == null) return;
    await _historyRef!.doc(id).delete();
  }

  Future<void> deleteAllHistory() async {
    if (_uid == null) return;

    final snapshot = await _historyRef!.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}