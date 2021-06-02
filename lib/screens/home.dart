import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/models/videos.dart';
import 'package:fluttertube/widgets/videotile.dart';

final _videoBloc = BlocProvider.getBloc<VideosBloc>();
final _favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 70,
          child: Image.asset("images/youtube_logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.grey,
        actions: <Widget>[
          Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                initialData: {},
                stream: _favoriteBloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                },
              )),
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null)
                _videoBloc.inSearch
                    .add(result); //(context).inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: _videoBloc.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    _videoBloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
