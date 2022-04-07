import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as jsonconvert;
import '../models/song.dart';

class ApiClient {
  void getSongs(Function successCallBack, Function failCallBack,
      {String searchValue = "sonunigam"}) {
    //
    //Future future;

    // final URL = "https://itunes.apple.com/search?term=$searchValue&limit=25";
    final URL = "${dotenv.env['BASE_URL']}?term=$searchValue&limit=25";
    Future<http.Response> future = http.get(Uri.parse(URL));
    future.then((response) {
      String json = response.body;
      // Doing JSON Conversion and Store in Song Model
      Map<String, dynamic> map =
          jsonconvert.jsonDecode(json); // JSON convert into MAP
      List<dynamic> list = map['results']; // Get the List from the Map
      List<Song> songs = list.map((songMap) => Song.fromJSON(songMap)).toList();
      print("Songs are $songs");
      successCallBack(songs);
      //var list = map['result'];
      /*List<Song> songs = list.map((element)=>
      Song(element['artistName'], element['trackName'],
       element['artworkUrl100'], element['previewUrl'])).toList(); // Traverse the List and get the one by one map
      */
      // and convert map into Song object and song object store in a Song List.
      //print("Map is $map and Map Type ${map.runtimeType}");
      //print("JSON $json");  // JSON Format
      //print(json.runtimeType);
    }).catchError((err) => failCallBack(err));
    //post(url)
    //return future;
  }
}
