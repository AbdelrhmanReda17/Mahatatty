import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection{
  static Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception('No Internet Connection');
    }
  }
}