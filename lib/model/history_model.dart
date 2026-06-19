import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String id;
  final String injury;
  final String severity;
  final String decision;
  final String injuryEmoji;
  final String confidencePercent;
  final bool goHospital;
  final List<String> firstAidSteps;
  final DateTime scannedAt;

  HistoryModel({
    required this.id,
    required this.injury,
    required this.severity,
    required this.decision,
    required this.injuryEmoji,
    required this.confidencePercent,
    required this.goHospital,
    required this.firstAidSteps,
    required this.scannedAt,
  });

  // CHANGED: Store scannedAt as Timestamp instead of String
  Map<String, dynamic> toMap() => {
        'id': id,
        'injury': injury,
        'severity': severity,
        'decision': decision,
        'injuryEmoji': injuryEmoji,
        'confidencePercent': confidencePercent,
        'goHospital': goHospital,
        'firstAidSteps': firstAidSteps,
        'scannedAt': Timestamp.fromDate(scannedAt), // CHANGED
      };

  factory HistoryModel.fromMap(Map<String, dynamic> map) => HistoryModel(
        id: map['id'] ?? '',
        injury: map['injury'] ?? '',
        severity: map['severity'] ?? '',
        decision: map['decision'] ?? '',
        injuryEmoji: map['injuryEmoji'] ?? '🏥',
        confidencePercent: map['confidencePercent'] ?? '0%',
        goHospital: map['goHospital'] ?? false,
        firstAidSteps: List<String>.from(map['firstAidSteps'] ?? []),

        // CHANGED
        scannedAt: map['scannedAt'] is Timestamp
            ? (map['scannedAt'] as Timestamp).toDate()
            : DateTime.now(),
      );

  String get formattedDate {
    final now = DateTime.now();
    final diff = now.difference(scannedAt);

    if (diff.inDays == 0) {
      final hour = scannedAt.hour;
      final minute = scannedAt.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return 'Today, $hour12:$minute $period';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${scannedAt.day} ${_month(scannedAt.month)}, ${scannedAt.year}';
    }
  }

  String _month(int m) => [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ][m];
}