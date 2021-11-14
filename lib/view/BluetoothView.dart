import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bluetooth/BluetoothConnectionService.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../SharedPreferencesService.dart';

class BluetoothView extends StatefulWidget{

  State<StatefulWidget> createState() {
    return BlueToothState(new SharedPreferencesService(), []);
  }
}

class BlueToothState extends State<BluetoothView>{
  List<BluetoothDevice> devices;
  SharedPreferencesService preferencesService;

  BlueToothState(this.preferencesService, this.devices){
    new BluetoothConnectionService().getDevices(this);
  }

  void increment(List<BluetoothDevice> devices) {
    setState(() {
      this.devices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index)=> ListTile(
                title: Text('${devices[index].name}'),
                onTap: ()=> preferencesService.addPairedBluetoothDevice(devices[index].name)
            )
        )
    );
  }
}