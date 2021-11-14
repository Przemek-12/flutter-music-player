import 'package:flutter_app/view/BluetoothView.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../main.dart';

class BluetoothConnectionService{

  BluetoothConnectionService(){}

  void getDevices(BlueToothState state) {

    FlutterBlue flutterBlue = FlutterBlue.instance;
    Future<dynamic> scanFuture = flutterBlue.startScan(timeout: Duration(seconds: 20));

    List<BluetoothDevice> scanResults = [];

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        print(scanResults.length);
        scanResults.add(result.device);
        state.increment(scanResults);
        print('${result.device.name} found! rssi: ${result.rssi}');
        // if(r.device.name.contains("UE55J6300")){
        //   await connectToDevice(r.device);
        //   flutterBlue.stopScan();
        //   List<BluetoothService> services = await r.device.discoverServices();
        //   services.forEach((service) {
        //     print("deviceId: "+service.deviceId.toString());
        //     print("service.characteristics");
        //     print(service.characteristics);
        //   });
        // }
      }
    });

    // flutterBlue.stopScan();

    scanFuture.whenComplete(() => print(" scan complete"));

  }

  Future<void> connectToDevice(BluetoothDevice device) async{
    // Connect to the device
    // await
    device.connect();
    // Disconnect from device
    device.disconnect();
  }



}


