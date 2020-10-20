import 'package:flutter/material.dart';
import 'package:youtube_estudos/Models/Video.dart';
import 'package:lottie/lottie.dart';
import "Api.dart";
class CustomShowSearch extends SearchDelegate<String> {
  CustomShowSearch(String placeholder):super(searchFieldLabel: placeholder);
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return<Widget>[
      IconButton(icon: Icon(Icons.close),
          onPressed: (){
          query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, "");
        });
  }
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    close(context,query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //throw UnimplementedError();
    List list_sugestions = List();
    if(query.isNotEmpty){


  Future<dynamic>  Pegar_titulos() {
      Api api = Api();
      return api.pesquisa(query);

    }

    return FutureBuilder<dynamic>(
      future: Pegar_titulos(),
      builder: (context,snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
             return Center(
               child: CircularProgressIndicator(),
             );
          case ConnectionState.done:
            if(snapshot.hasData) {
              list_sugestions = snapshot.data;

              return ListView.builder(
                  itemCount: list_sugestions.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(list_sugestions[index].title),
                      onTap:() {
                        close(context, list_sugestions[index].title);
                      },
                    );
                  }
              );
            }
        }
      },
    );
    }
    else {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
      Text('Pesquise para encontrar videos'),
    Lottie.asset("animations/search.json",width: 200),
    ],
    ),
    );
    }
  }

}
