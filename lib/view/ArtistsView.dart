import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'ArtistAlbumsView.dart';

class ArtistsView extends StatefulWidget{

  final FlutterAudioQuery flutterAudioQuery;

  ArtistsView(this.flutterAudioQuery);

  @override
  State<StatefulWidget> createState() {
    return new _ArtistsViewState(flutterAudioQuery);
  }
}

class _ArtistsViewState extends State<ArtistsView>{

  FlutterAudioQuery flutterAudioQuery;

  _ArtistsViewState(this.flutterAudioQuery);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistInfo>>(
        future: flutterAudioQuery.getArtists(),
        builder: (BuildContext context, AsyncSnapshot<List<ArtistInfo>> snapshot){
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

  Scaffold listView(List<ArtistInfo> artists){
    return Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index)=> ListTile(
              title: Text('${artists[index].name}'),
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtistAlbumsView(flutterAudioQuery, artists[index].name)),
                );
              },
            ),
            itemCount: artists.length
        )
    );
  }

}
