import 'dart:async';
import 'package:get/get.dart';
import 'package:mediaid_ui/model/history_model.dart';
import 'package:mediaid_ui/services/history_service.dart';

class HistoryController extends GetxController {
  final HistoryService _service = HistoryService();

  var historyList = <HistoryModel>[].obs;
  var isLoading = true.obs;

  StreamSubscription? _historySubscription;

  @override
  void onInit() {
    super.onInit();
    listenToHistory(); // CHANGED
  }

  // CHANGED: Real-time listener
  void listenToHistory() {
    _historySubscription = _service.getHistoryStream().listen((history) {
      historyList.assignAll(history);
      isLoading.value = false;
    });
  }

  Future<void> deleteScan(String id) async {
    await _service.deleteScan(id);
  }

  Future<void> deleteAll() async {
    await _service.deleteAllHistory();
  }

  @override
  void onClose() {
    _historySubscription?.cancel();
    super.onClose();
  }
}