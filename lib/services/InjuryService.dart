// ============================================================
// injury_classifier.dart
// On-device TFLite inference + first aid guidance lookup
// ============================================================

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mediaid_ui/model/resultModel.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class Injuryservice {
  // ── Model constants (confirmed from model inspection) ──────────
  static const int INPUT_SIZE  = 224;
  static const int NUM_CLASSES = 10;

  Interpreter?  _interpreter;
  List<String>  _labels = [];
  bool          _isLoaded = false;

  // ── First Aid Database ─────────────────────────────────────────
  // Keys use normalized labels (see _normalizeLabel below)
  static const Map<String, Map<String, dynamic>> _firstAidDB = {
    'normal': {
      'decision':   '✅ No Injury Detected',
      'severity':   'none',
      'goHospital': false,
      'steps': [
        'No treatment needed.',
        'Monitor the area if you feel any pain.',
        'Consult a doctor if symptoms develop.',
      ],
    },

    'abrasions': {
      'decision':   '🏠 Home Care',
      'severity':   'mild',
      'goHospital': false,
      'steps': [
        'Rinse the area under clean running water for 5 minutes.',
        'Gently clean with mild soap — avoid scrubbing.',
        'Apply antiseptic cream (Dettol / Savlon).',
        'Cover with a sterile bandage.',
        'Change dressing daily. Watch for redness or swelling.',
      ],
    },

    'bruises': {
      'decision':   '🏠 Home Care',
      'severity':   'mild',
      'goHospital': false,
      'steps': [
        'Apply an ice pack wrapped in cloth for 15–20 minutes.',
        'Elevate the bruised area above heart level.',
        'Rest and avoid pressure on the area.',
        'After 48 hours, apply warm compress to aid healing.',
        'Take paracetamol for pain if needed.',
      ],
    },

    'burns': {
      'decision':   '⚠️ Depends on Severity',
      'severity':   'moderate',
      'goHospital': false,   // upgraded to severe if confidence ≥ 0.80
      'steps': [
        'Cool under cold running water for 10–20 minutes. Do NOT use ice.',
        'Do NOT apply butter, toothpaste, or oil.',
        'Remove jewelry or tight items near the burn.',
        'Cover loosely with a clean non-fluffy bandage.',
        'If blisters appear or area is large → Go to hospital immediately.',
      ],
    },

    'cut': {
      'decision':   '⚠️ Depends on Severity',
      'severity':   'moderate',
      'goHospital': false,   // upgraded to severe if confidence ≥ 0.80
      'steps': [
        'Apply firm pressure with a clean cloth to stop bleeding.',
        'Rinse under clean water for 5 minutes.',
        'Apply antiseptic and cover with a bandage.',
        'If bleeding does not stop in 10 minutes → Go to hospital.',
        'If cut is deep or wide → Go to hospital for stitches.',
      ],
    },

    'laseration': {
      'decision':   '🚨 Go to Hospital Immediately',
      'severity':   'severe',
      'goHospital': true,
      'steps': [
        'Apply firm pressure with a clean cloth — do NOT remove it.',
        'Keep the injured area elevated above heart level.',
        'Do NOT remove any embedded objects.',
        'Call emergency services (115 in Pakistan) immediately.',
        'Keep the person calm and still until help arrives.',
      ],
    },

    'diabetic': {
      'decision':   '🚨 Go to Hospital Immediately',
      'severity':   'severe',
      'goHospital': true,
      'steps': [
        'Do NOT walk on the wound if it is on the foot.',
        'Cover gently with a clean bandage.',
        'Do NOT apply any home remedies.',
        'Go to hospital immediately — diabetic wounds worsen rapidly.',
        'Strict blood sugar control is essential for healing.',
      ],
    },

    'pressure': {
      'decision':   '🚨 Go to Hospital Immediately',
      'severity':   'severe',
      'goHospital': true,
      'steps': [
        'Do NOT press or rub the wound.',
        'Gently cover with a clean sterile dressing.',
        'Reposition the patient to relieve pressure on the area.',
        'Seek medical attention immediately.',
        'These wounds require professional wound care treatment.',
      ],
    },

    'surgical': {
      'decision':   '🚨 Contact Your Doctor',
      'severity':   'severe',
      'goHospital': true,
      'steps': [
        'Do NOT touch or probe the wound.',
        'Keep the area clean and dry at all times.',
        'Watch for signs of infection: redness, swelling, pus, or fever.',
        'Contact your surgeon or go to hospital immediately.',
        'Do NOT remove surgical dressings without medical advice.',
      ],
    },

    'venous': {
      'decision':   '🚨 See a Doctor',
      'severity':   'severe',
      'goHospital': true,
      'steps': [
        'Elevate the leg above heart level.',
        'Apply a clean dressing to the wound.',
        'Do NOT wrap tightly — it can worsen circulation.',
        'Seek medical attention as soon as possible.',
        'These wounds require professional compression therapy.',
      ],
    },
  };

  // ── Initialize: load model + labels ───────────────────────────
  Future<void> initialize() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/mediaid_model.tflite',
        options: InterpreterOptions()..threads = 4,
      );

      final raw = await rootBundle.loadString('assets/models/labels.txt');
      _labels   = raw.split('\n').where((l) => l.trim().isNotEmpty).toList();

      _isLoaded = true;
      print('✅ MediAid model loaded — ${_labels.length} classes: $_labels');
    } catch (e) {
      _isLoaded = false;
      print('❌ Model load failed: $e');
    }
  }

  bool get isLoaded => _isLoaded;

  // ── Normalize label for DB lookup ─────────────────────────────
  // "Diabetic Wounds" → "diabetic"
  // "Pressure Wounds" → "pressure"
  // "Surgical Wounds" → "surgical"
  // "Venous Wounds"   → "venous"
  // "Abrasions"       → "abrasions"  (unchanged)
// Updated _normalizeLabel function in injury_classifier.dart
String _normalizeLabel(String raw) {
  String normalized = raw.trim().toLowerCase();
  
  // Handle specific cases from your labels.txt
  switch (normalized) {
    case 'diabetic wounds':
      return 'diabetic';
    case 'pressure wounds':
      return 'pressure';
    case 'surgical wounds':
      return 'surgical';
    case 'venous wounds':
      return 'venous';
    case 'abrasions':
      return 'abrasions';
    case 'bruises':
      return 'bruises';
    case 'burns':
      return 'burns';
    case 'cut':
      return 'cut';
    case 'laseration':
      return 'laseration';
    case 'normal':
      return 'normal';
    default:
      return normalized;
  }
}
  // ── Main classify method ───────────────────────────────────────
  Future<ResultModel?> classify(File imageFile) async {
    if (!_isLoaded || _interpreter == null) {
      print('❌ Classifier not initialized');
      return null;
    }

    try {
      // 1. Preprocess
      final input  = _preprocessImage(imageFile);

      // 2. Prepare output buffer
      final output = List.filled(NUM_CLASSES, 0.0).reshape([1, NUM_CLASSES]);

      // 3. Run inference
      _interpreter!.run(input, output);

      // 4. Get top prediction
      final scores   = (output[0] as List).cast<double>();
      final maxScore = scores.reduce((a, b) => a > b ? a : b);
      final maxIndex = scores.indexOf(maxScore);
      final rawLabel = _labels[maxIndex];           // e.g. "Diabetic Wounds"
      final normKey  = _normalizeLabel(rawLabel);   // e.g. "diabetic"

      // Debug (remove after testing)
      print('🔍 Raw label : $rawLabel');
      print('🔑 Norm key  : $normKey');
      print('📊 Confidence: ${(maxScore * 100).toStringAsFixed(1)}%');
      print('✅ DB hit    : ${_firstAidDB.containsKey(normKey)}');

      // 5. Look up first aid guidance
      final base = Map<String, dynamic>.from(
        _firstAidDB[normKey] ?? _firstAidDB['normal']!,
      );

      // 6. Confidence-based severity upgrade for Burns & Cut
      if ((normKey == 'burns' || normKey == 'cut') && maxScore >= 0.80) {
        base['decision']   = '🚨 Go to Hospital Immediately';
        base['severity']   = 'severe';
        base['goHospital'] = true;
      }

      return ResultModel(
        injury:        rawLabel.trim(),                      // display as-is
        confidence:    maxScore,
        severity:      base['severity']   as String,
        decision:      base['decision']   as String,
        goHospital:    base['goHospital'] as bool,
        firstAidSteps: List<String>.from(base['steps']),
        isOffline:     true,
      );
    } catch (e) {
      print('❌ Inference error: $e');
      return null;
    }
  }

  // ── Image preprocessing ────────────────────────────────────────
  // Input shape: [1, 224, 224, 3]  dtype: float32  range: [0.0, 1.0]
  List<List<List<List<double>>>> _preprocessImage(File imageFile) {
    final bytes  = imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(bytes);
    image = img.copyResize(image!, width: INPUT_SIZE, height: INPUT_SIZE);

    return List.generate(1, (_) =>
      List.generate(INPUT_SIZE, (y) =>
        List.generate(INPUT_SIZE, (x) {
          final pixel = image!.getPixel(x, y);
          return [
            pixel.r / 255.0,
            pixel.g / 255.0,
            pixel.b / 255.0,
          ];
        }),
      ),
    );
  }

  void dispose() => _interpreter?.close();
}