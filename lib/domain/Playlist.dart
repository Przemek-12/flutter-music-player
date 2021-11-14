import 'package:flutter_audio_query/flutter_audio_query.dart';

class Playlist{
  int id;
  String _name;
  List<SongInfo> _playlist;

  Playlist(this.id, this._name, this._playlist);

  set name(String name){
    this._name = name;
  }

  String get name{
    return _name;
  }

  set playlist(List<SongInfo> playlist){
    this._playlist = playlist;
  }

  List<SongInfo> get playlist{
    return _playlist;
  }
}