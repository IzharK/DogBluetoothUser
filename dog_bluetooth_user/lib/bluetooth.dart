import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const bluetoothChannel = MethodChannel('bluetooth');

Future<void> enableBluetooth() async {
  try {
    await bluetoothChannel.invokeMethod('enableBluetooth');
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("Failed to enable Bluetooth: ${e.message}");
    }
  }
}
