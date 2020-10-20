import 'package:http/http.dart';
import 'dart:convert';
import './Models/Video.dart';
String Url_base = "https://www.googleapis.com/youtube/v3/";

const CHAVE_YOTUBE_API = "AIzaSyDnGq8rSQ86sps3uGk_4zoZx-7PxyXFYzE";

class Api {
  pesquisa(String pesquisa) async {
  Response response = await get(
   Url_base + "search"
    "?part=snippet"
    "&maxResults=20"
   "&order=date"
   "&key=${CHAVE_YOTUBE_API}"
   "&q=${pesquisa}"
  );
  var datajson = json.decode(response.body);
  List list_json = datajson["items"];
  List<Video> videos = [];
  for(var mapvideo in list_json) {
    Video video = Video(
        title: mapvideo["snippet"]["title"],

      description: mapvideo["snippet"]["description"],
      thumb_url: mapvideo["snippet"]["thumbnails"]["high"]["url"],
      chaneltitle:  mapvideo["snippet"]["channelTitle"],
      video_id:   mapvideo["id"]["videoId"],


    );
    videos.add(video);

  }
  return videos;





  }
}
