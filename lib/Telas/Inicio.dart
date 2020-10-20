import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Api.dart';
import '../Models/Video.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
 class Inicio extends StatefulWidget {
   String pesquisa;
   Inicio(this.pesquisa);
   @override
   _InicioState createState() => _InicioState();

 }

 class _InicioState extends State<Inicio> {

   Future<dynamic>listar_videos(String pesquisa) {
     Api api = new Api();




     return api.pesquisa(pesquisa);


   }

   @override
   Widget build(BuildContext context) {



     return Container(

       child: FutureBuilder<dynamic>(
         future: listar_videos(widget.pesquisa),
         builder: (context,snapshot){
           switch(snapshot.connectionState) {
             case ConnectionState.waiting:
                return Center(
                  child: Lottie.asset("animations/video.json"),
                );
             case ConnectionState.done:
               if(snapshot.hasError) {
                 return Center(
                   child: Lottie.asset("animations/video.json"),
                 );
               }
               else if(snapshot.data.length == 0) {
                 return Center(
                   child: Lottie.asset("animations/404.json", height: 600),
                 );
               }
               else {
                 List<Video> videos = snapshot.data;
                 return ListView.builder(itemCount: videos.length,
                   itemBuilder: (context,indice){




                   return GestureDetector(
                     onTap:  (){
                       FlutterYoutube.playYoutubeVideoById(
                           apiKey: CHAVE_YOTUBE_API,
                           videoId: videos[indice].video_id,
                         autoPlay: true,
                          fullScreen: true,
                       );
                     },
                     child: Column(
                       children: <Widget>[
                         Container(
                             height: 200,
                             decoration:  BoxDecoration(
                                 image: DecorationImage(
                                   image: NetworkImage(videos[indice].thumb_url),
                                   fit: BoxFit.cover,
                                 )
                             )
                         ),
                         ListTile(
                           title: Text(videos[indice].title),
                           subtitle: Text(videos[indice].chaneltitle),

                         )

                       ],
                     )

                   );
                   },
                 );
               }


           }
         },
       ),

       );

   }
 }

