import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{

  final String _PAIRED_DEVICES_PROPERTY = "pairedDevices";

  void addPairedBluetoothDevice(String name) async {
    SharedPreferences prefs = await _getInstance();
    _initListIfNotPresent(prefs);
    List<String> devices = _getDevices(prefs);
    if(!devices.contains(name)) {
      devices.add(name);
      _setList(prefs, devices);
    }
    print(_getDevices(prefs));
  }

  void removePairedDevice(String name) async{
    SharedPreferences prefs = await _getInstance();
    List<String> devices = _getDevices(prefs);
    devices.remove(name);
    _setList(prefs, devices);
  }

  Future<List<String>> getPairedDevices() async {
    SharedPreferences prefs = await _getInstance();
    return _getDevices(prefs);
  }

  void _initListIfNotPresent(SharedPreferences prefs) async {
    if(_getDevices(prefs)==null){
      _setList(prefs, []);
    }
  }

  List<String> _getDevices(SharedPreferences prefs){
    return prefs.getStringList(_PAIRED_DEVICES_PROPERTY);
  }

  void _setList(SharedPreferences prefs, List<String> devices){
    prefs.setStringList(_PAIRED_DEVICES_PROPERTY, devices);
  }

  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }
}