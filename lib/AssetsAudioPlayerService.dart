import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_app/view/PlayerView.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AssetsAudioPlayerService{

  static AssetsAudioPlayerService _assetsAudioPlayerService;

  AssetsAudioPlayer _audioPlayer;
  PlayerViewState _playerViewStateInstance;

  AssetsAudioPlayerService._(){
    _audioPlayer = AssetsAudioPlayer();
    _audioPlayer.setLoopMode(LoopMode.playlist);
  }

  static AssetsAudioPlayerService instance(PlayerViewState state){
    if(_assetsAudioPlayerService==null){
      _assetsAudioPlayerService = AssetsAudioPlayerService._();
    }
    _assetsAudioPlayerService._playerViewState=state;
    return _assetsAudioPlayerService;
  }

  set _playerViewState(PlayerViewState state){
    this._playerViewStateInstance = state;
    _initEventListeners();
  }

  // sets song album as playlist
  open(List<SongInfo> playlist, int startIndex){
    if(_audioPlayer.isPlaying!=null) {
      _audioPlayer.stop();
    }
    List<Audio> audios = [];
    playlist.forEach((song) {
      audios.add(Audio.file(
          song.filePath,
          metas: Metas(
              album: song.album,
              artist: song.artist,
              title: song.title,
              extra: {"duration": song.duration}
          )
      )
      );
    });
    _audioPlayer.open(Playlist(
        audios: audios,
        startIndex: startIndex
        ),
        showNotification: true,
        respectSilentMode: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug
    );
  }

  playOrPause(){
    _audioPlayer.playOrPause();
  }

  loopSong(){
    if(_audioPlayer.currentLoopMode==LoopMode.single){
      _audioPlayer.setLoopMode(LoopMode.none);
    }else{
      _audioPlayer.setLoopMode(LoopMode.single);
    }
  }

  loopPlaylist(){
    if(_audioPlayer.currentLoopMode==LoopMode.playlist){
      _audioPlayer.setLoopMode(LoopMode.none);
    }else{
      _audioPlayer.setLoopMode(LoopMode.playlist);
    }
  }

  next(){
    _audioPlayer.next(keepLoopMode: false);
  }

  previous(){
    _audioPlayer.previous(keepLoopMode: false);
  }

  stop(){
    _audioPlayer.stop();
  }

  changeCurrentPosition(double milliseconds){
    _audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
  }

  void _initEventListeners(){
    _currentPositionListener();
    _playerStateListener();
  }

  void _currentPositionListener(){
    _audioPlayer.currentPosition.listen((event) {
      _playerViewStateInstance.setSliderAndTimerValue(event.inMilliseconds);
    });
  }

  void _playerStateListener(){
    _audioPlayer.playerState.listen((event) {
      if(event == PlayerState.play){
        _playerViewStateInstance.setPlay(
            _audioPlayer.getCurrentAudioArtist,
            _audioPlayer.getCurrentAudioTitle,
            _audioPlayer.getCurrentAudioextra
        );
      }
      if(event == PlayerState.pause){
        _playerViewStateInstance.setPause();
      }
    });
  }

}