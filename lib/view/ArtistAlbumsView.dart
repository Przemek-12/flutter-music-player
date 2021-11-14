import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'AlbumSongsView.dart';

class ArtistAlbumsView extends StatefulWidget{

  final FlutterAudioQuery flutterAudioQuery;
  final String artist;

  ArtistAlbumsView(this.flutterAudioQuery, this.artist);

  @override
  State<StatefulWidget> createState() {
    return new _ArtistAlbumsViewState(flutterAudioQuery, artist);
  }
}

class _ArtistAlbumsViewState extends State<ArtistAlbumsView>{

  final FlutterAudioQuery flutterAudioQuery;
  final String artist;

  _ArtistAlbumsViewState(this.flutterAudioQuery, this.artist);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumInfo>>(
        future: flutterAudioQuery.getAlbumsFromArtist(artist: artist),
        builder: (BuildContext context, AsyncSnapshot<List<AlbumInfo>> snapshot){
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

  Scaffold listView(List<AlbumInfo> albums){
    return  Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index)=> ListTile(
              title: Text('${albums[index].title}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlbumSongsView(flutterAudioQuery, albums[index].id)),
                );
              },
            ),
            itemCount: albums.length
        )
    );
  }

}