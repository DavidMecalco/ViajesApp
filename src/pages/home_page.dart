
import 'package:flutter/material.dart';
import 'package:peliculas_udemy/src/providers/peliculas_provider.dart';
import 'package:peliculas_udemy/src/search/serch_delegate.dart';
import 'package:peliculas_udemy/src/widgets/card_swiper_card.dart';
import 'package:peliculas_udemy/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar:  AppBar(
        title: Text('The Movies App'),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
          onPressed: (){
            showSearch(
              context: context,
              delegate: DataSearch(),
              );
          })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _foother(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data);
        }else{
          return Container(
            height: 100.0,
            child: Center(child: CircularProgressIndicator())
            );
        }
      },
    );
  }

 Widget _foother(BuildContext context) {

   return Container(

     width: double.infinity,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         Container(
           padding: EdgeInsets.only(left: 20.0),
           child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
           ),
         SizedBox(height: 5.0,),
         
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguentePagina: peliculasProvider.getPopulares,  
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }


            },
          ),
       ],

     ),

   );

 }
}