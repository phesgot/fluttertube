import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {

  Map<String, Video> _favorites = {};

  final StreamController<Map<String,Video>> _favController = StreamController<Map<String,Video>>.broadcast();
  Stream <Map<String,Video>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favo"))
    });
  }


  void toggleFavorites(Video video){
    if(_favorites.containsKey(video.id)) _favorites.remove(video.id);
        else _favorites[video.id] = video;

        _favController.sink.add(_favorites);
  }


  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favController.close();
  }



  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }}
