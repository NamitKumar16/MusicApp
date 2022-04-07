class Song{
  late String artistName; // title of the song;
  late String trackName; 
  late String image; // Image URL
  late String audio; // Audio URL
  Song(this.artistName, this.trackName, this.image , this.audio);
  // Manual Serialization and DeSerialization
  // Serialization - Object to JSON Conversion
  // Deserialization - JSON to Object Conversion
  // Named Constructor 
  Song.fromJSON(Map<String,dynamic> map ){
    artistName = map['artistName'];
    trackName = map['trackName'];
    image = map['artworkUrl100'];
    audio = map['previewUrl'];
  }
  Map<String, dynamic> toJSON(){
    return {
      "artistName":artistName,
      "trackName":trackName,
      "artworkUrl100":image,
      "previewUrl":audio
    };
  }
  // To print meaning full object use toString
  @override
  String toString(){
    return "artistName $artistName TrackName $trackName ";
  }
}