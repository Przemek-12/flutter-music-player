import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../AssetsAudioPlayerService.dart';

class PlayerView extends StatefulWidget{

  final int _startIndex;
  final List<SongInfo> _songs;

  PlayerView(this._songs, this._startIndex);

  @override
  State<StatefulWidget> createState() {
    return PlayerViewState(_songs, _startIndex);
  }
}

class PlayerViewState extends State<PlayerView>{

  AssetsAudioPlayerService playerService;
  int _currentIndex;
  List<SongInfo> _songs;
  String _title = "";
  double _sliderValue = 0;
  String _msDuration = "0";
  IconData _playOrPauseIconData = Icons.play_arrow;
  bool _isVisible = true;
  String _timerValue = "00:00";

  PlayerViewState(this._songs, this._currentIndex){
    playerService = AssetsAudioPlayerService.instance(this);
    playerService.open(_songs, _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isVisible,
        child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 height: 50.0,
                 // child: Image.asset(
                 //   // _songs[_currentIndex].albumArtwork,
                 //   width: 200,
                 //   height: 200,
                 // ),
               ),
               Text(_title),
               _timer(),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   _previousBtn(),
                   _playBtn(),
                   _nextBtn(),
                   _stopBtn()
                 ],
               ),
               _slider()
              ]
        ),
      )
    );
  }

  void setPlay(String artist, String song, Map<String, dynamic> extras){
    setState(() {
      _title = artist + " - " + song;
      _playOrPauseIconData = Icons.pause;
      _msDuration = extras["duration"];
    });
  }

  void setPause(){
    setState(() {
      _playOrPauseIconData = Icons.play_arrow;
    });
  }

  void setSliderAndTimerValue(int milliseconds){
    setState(() {
      _sliderValue = milliseconds.toDouble();
      
      String getDisplayTimeByMs(int milliseconds){
        int allSeconds = milliseconds~/1000;
        int minutes = allSeconds~/60;
        int seconds = allSeconds -(minutes*60);
        String valueToDisp (int number){
          if(number<10){
            return "0"+number.toString();
          }
          return number.toString();
        }
        return valueToDisp(minutes)+":"+valueToDisp(seconds);
      }
      
      _timerValue = getDisplayTimeByMs(milliseconds)+"/"+getDisplayTimeByMs(int.parse(_msDuration));
    });
  }

  IconButton _nextBtn(){
    return IconButton(
      iconSize: 50.0,
      icon: Icon(Icons.skip_next),
      onPressed: ()=>setState((){
        playerService.next();
      }),
    );
  }

  IconButton _previousBtn(){
    return IconButton(
      iconSize: 50.0,
      icon: Icon(Icons.skip_previous),
      onPressed: ()=>setState((){
        playerService.previous();
      }),
    );
  }

  IconButton _playBtn(){
    return IconButton(
      iconSize: 70.0,
      icon: Icon(_playOrPauseIconData),
      onPressed: ()=>playerService.playOrPause(),
    );
  }

  IconButton _stopBtn(){
    return IconButton(
      iconSize: 50.0,
      icon: Icon(Icons.stop),
      onPressed: ()=>playerService.stop(),
    );
  }

  Slider _slider(){
    return Slider(
        value: _sliderValue,
        min: 0,
        max: double.parse(_msDuration),
        onChanged: (double value){
          playerService.changeCurrentPosition(value);
        }
    );
  }

  Text _timer(){
    return Text(_timerValue);
  }

}