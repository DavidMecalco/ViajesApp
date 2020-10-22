import 'package:flutter/material.dart';
import 'package:peliculas_udemy/src/models/actores_model.dart';
import 'package:peliculas_udemy/src/models/pelicula_model.dart';
import 'package:peliculas_udemy/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: 
              SliverChildListDelegate([
                SizedBox(height: 30.0),
                _postertitulo( context , pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula)
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        ),
        background: FadeInImage(
        image: NetworkImage(pelicula.getBackgroundImg()),
        placeholder: AssetImage('assets/img/loading.gif'),
        fadeInDuration: Duration(seconds: 2),
        fit: BoxFit.cover,
        ),
      ),
    );

  }

   Widget _postertitulo(BuildContext context ,Pelicula pelicula) {
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
       child: Row(
         children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                  image: NetworkImage(pelicula.getImagePoster()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Titulo: ${pelicula.title}', style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
                  Text('Titulo original: ${ pelicula.originalTitle}', style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                  Row(
                    children: <Widget>[
                      Text('Calificación: ${ pelicula.voteAverage.toString() }', style: Theme.of(context).textTheme.subhead),
                      Icon (Icons.star, color: Colors.amber),
                    ],
                  )
                ],
              ) 
            )
         ],
       ),
     );
   }

  _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18.0),
        ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );


  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.28,
          initialPage: 0
        ),
        itemCount: actores.length,
        itemBuilder: (context, i){
          return _actorTarjeta(actores[i]);
        },
      ),
    );

  }

  Widget _actorTarjeta( Actor actor ){

    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.contain,
              ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            )
        ],
      ),
    );

  }

}