import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';

final _videoBloc = BlocProvider.getBloc<VideosBloc>();

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
        backgroundColor: Colors.black45,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: (){}
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: DataSearch());
                if(result != null)
                  _videoBloc.inSearch.add(result);//(context).inSearch.add(result);
              },
              )
        ],
      ),
      body: Container(),
    );
  }
}
