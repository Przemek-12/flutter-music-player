import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'ArtistsView.dart';
import 'BluetoothView.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text("Bluetooth search"),
              onPressed: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>BluetoothView())
              )
          ),
          ElevatedButton(
              child: Text("music"),
              onPressed: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>ArtistsView(FlutterAudioQuery()))
              )
          )
        ],
      ),
    );

  }
}