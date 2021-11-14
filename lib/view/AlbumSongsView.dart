import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'PlayerView.dart';

class AlbumSongsView extends StatefulWidget{

  final FlutterAudioQuery flutterAudioQuery;
  final String albumId;

  AlbumSongsView(this.flutterAudioQuery, this.albumId);

  @override
  State<StatefulWidget> createState() =>
     new _AlbumSongsViewState(flutterAudioQuery, albumId);

}

class _AlbumSongsViewState extends State<AlbumSongsView>{

  final FlutterAudioQuery flutterAudioQuery;
  final String albumId;

  _AlbumSongsViewState(this.flutterAudioQuery, this.albumId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongInfo>>(
        future: flutterAudioQuery.getSongsFromAlbum(albumId: albumId),
        builder: (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot){
          if(snapshot.hasData){
            return listView(snapshot.data);
          }else{
            return loadingIcon();
          }
        }
    );
  }

  SizedBox loadingIcon(){
    return SizedBox(
      // child: CircularProgressIndicator(),
      // width: 60,
      // height: 60,
    );
  }

  Scaffold listView(List<SongInfo> songs){
    return  Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index)=> ListTile(
              title: Text('${songs[index].displayName}'),
              onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>PlayerView(songs, index))
              ),
            ),
            itemCount: songs.length
        )
    );
  }
}