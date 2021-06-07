import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/videos.dart';
import 'package:http/http.dart';

final _favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FlutterYoutube.playYoutubeVideoById(
            apiKey: API_KEY,
            videoId: video.id,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(video.thumb, fit: BoxFit.cover),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(video.channel,
                            style: TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: _favoriteBloc.outFav,
                    initialData: {},
                    builder: (context, sanapshot) {
                      if (sanapshot.hasData) {
                        return IconButton(
                          icon: Icon(sanapshot.data.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border),
                          color: Colors.amber,
                          iconSize: 30,
                          onPressed: () {
                            _favoriteBloc.toggleFavorites(video);
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
