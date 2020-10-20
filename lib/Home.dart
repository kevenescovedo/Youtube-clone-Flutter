import 'package:flutter/material.dart';
import 'Telas/Inicio.dart';
import 'Telas/Inscricoes.dart';
import 'Telas/EmAlta.dart';
import 'Telas/Biblioteca.dart';
import 'CustomShowSearch.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
String resultado = "";
int IndiceAtual = 0;
class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(resultado),
      Emalta(),
      Inscricoes(),

      Biblioteca()
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/youtube.png", width: 90,),
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 0.7
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: (){},

          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
           String res =  await  showSearch(context: context, delegate: CustomShowSearch("Pesquisa") );
           print(res);
           setState(() {
             resultado = res;
           });
            },

          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){},

          )
        ],
      ) ,
      body: telas[IndiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.red,
        onTap: (indice){
          setState(() {
            IndiceAtual = indice;
          });

        },
        currentIndex: IndiceAtual,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Início"),

          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text("Em alta"),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            title: Text("Inscrições"),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text("Biblioteca"),

          ),
        ],
      ),
    );

  }
}
