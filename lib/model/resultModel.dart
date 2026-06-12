// ============================================================
// result_model.dart
// Holds the prediction result passed from classifier → UI
// ============================================================

class ResultModel {
  final String injury;          // Raw label e.g. "Diabetic Wounds"
  final double confidence;      // 0.0 – 1.0
  final String severity;        // "none" | "mild" | "moderate" | "severe"
  final String decision;        // Human-readable recommendation
  final bool goHospital;        // true = emergency / hospital needed
  final List<String> firstAidSteps;
  final bool isOffline;         // true = on-device, false = server

  ResultModel({
    required this.injury,
    required this.confidence,
    required this.severity,
    required this.decision,
    required this.goHospital,
    required this.firstAidSteps,
    required this.isOffline,
  });

  // ── Formatted confidence e.g. "87.3%" ──────────────────────────
  String get confidencePercent => "${(confidence * 100).toStringAsFixed(1)}%";

  // ── Severity emoji ──────────────────────────────────────────────
  String get severityEmoji => switch (severity.toLowerCase()) {
    'severe'   => '🔴',
    'moderate' => '🟠',
    'mild'     => '🟡',
    _          => '✅',   // none
  };

  // ── Injury emoji (matches raw label from labels.txt) ───────────
  String get injuryEmoji => switch (injury.toLowerCase()) {
    'burns'           => '🔥',
    'cut'             => '🩸',
    'abrasions'       => '🩹',
    'bruises'         => '💜',
    'laseration'      => '🩸',
    'diabetic wounds' => '💉',
    'surgical wounds' => '🏥',
    'venous wounds'   => '🫀',
    'pressure wounds' => '⚠️',
    'normal'          => '✅',
    _                 => '🏥',
  };

  // ── Severity color helper (use in UI) ──────────────────────────
  // Returns a string token your UI can switch on
  String get severityLevel => severity.toLowerCase();
}