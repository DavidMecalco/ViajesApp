import 'package:flutter/material.dart';
import 'package:peliculas_udemy/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguentePagina;

  MovieHorizontal({ @required this.peliculas, @required this.siguentePagina });

  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _sreenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

        if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
          siguentePagina();
        }

    });


    return Container(
      
      height: _sreenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i){
          return _tarjeta(context, peliculas[i]);
        }
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${ pelicula.id}-poster';

    final peliuclaTarjeta = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Column(

          children: <Widget>[
            Hero(
                  tag: pelicula.uniqueId,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getImagePoster()),
                  fit: BoxFit.cover,
                  height: 200.0,
                    ),
                  ),
              ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
         ),
      );

      return GestureDetector(
        child: peliuclaTarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'datalle', arguments: pelicula);
        },
      );    

  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 1.0),
        child: Column(

          children: <Widget>[

            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getImagePoster()),
                fit: BoxFit.cover,
                height: 10.0,
                ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
         ),
      );

    }).toList();

  }
}