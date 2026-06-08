import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  
  // One-time check
  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Stream — listens for changes (online → offline)
  Stream<bool> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map(
      (result) => result != ConnectivityResult.none,
    );
  }
}