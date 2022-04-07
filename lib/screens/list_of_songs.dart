import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/utils/api_client.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({Key? key}) : super(key: key);

  @override
  _ListOfSongsState createState() => _ListOfSongsState();
}
ApiClient client = ApiClient();
class _ListOfSongsState extends State<ListOfSongs> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<Song> songs = [];
  dynamic error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
  }

  getSongList(List<Song> songs) {
    this.songs = songs;
    setState(() {});
  }

  getSongError(dynamic error) {
    this.error = error;
    setState(() {});
  }

  Center _showLoading() {
    return Center(child: CircularProgressIndicator());
  }

  ListView _printSong() {
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(
          leading: Image.network(songs[index].image),
          title: Text(songs[index].trackName),
          subtitle: Text(songs[index].artistName),
          trailing: IconButton(
              onPressed: () async {
                print("Song Play ${songs[index].audio}");
                await audioPlayer.play(songs[index].audio);
              },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: Colors.redAccent,
              )),
        );
      },
      itemCount: songs.length,
    );
  }

  TextEditingController searchCtrl = TextEditingController();
  _searchSongs() {
    String searchValueTxt = searchCtrl.text;
    client.getSongs(getSongList, getSongError,searchValue: searchValueTxt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          title: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                    onPressed: () {
                      // print("Search");
                    },
                    icon: Icon(Icons.search)),
                labelText: 'Search Here',
                hintText: 'Type to Search',
              ),
            ),
          )),
      // title: Text('Songs'),),
      body:
          Container(child: (songs.length == 0) ? _showLoading() : _printSong()),
    );
  }
}
