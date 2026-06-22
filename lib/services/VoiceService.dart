import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {

  final FlutterTts tts = FlutterTts();

  Future init({Function()? onComplete}) async {

    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.45);
    await tts.setPitch(1.0);

    tts.setCompletionHandler(() {

      if (onComplete != null) {
        onComplete();
      }

    });
  }

  Future speak(String text) async {
    await tts.stop();
    await tts.speak(text);
  }

  Future stop() async {
    await tts.stop();
  }
}