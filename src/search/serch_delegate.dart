
import 'package:flutter/material.dart';
import 'package:peliculas_udemy/src/models/pelicula_model.dart';
import 'package:peliculas_udemy/src/providers/peliculas_provider.dart';


class DataSearch extends SearchDelegate<dynamic> {

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();


  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro appbar
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){
          query = '';
        })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(
          context,
          null);
        }
        );
    }

    @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }
  

    @override
    Widget buildSuggestions(BuildContext context) {
    // Crea las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getImagePoster()),
                  width: 50.0,
                  fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'datalle', arguments: pelicula);
                  },
              );
            }).toList()
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );



  }
 


}