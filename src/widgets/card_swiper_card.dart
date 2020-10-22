import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_udemy/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.only(left: 20.0),
    
      child: Swiper(
          layout: SwiperLayout.STACK,
            itemWidth: _screenSize.width * 0.5,
            itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){ 

            peliculas[index].uniqueId = '${ peliculas[index].id}-tarjeta';

            return Hero(
                tag: peliculas[index].uniqueId,
                child: ClipRRect(

                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'datalle', arguments: peliculas[index]),
                    child: FadeInImage(
                    image: NetworkImage( peliculas[index].getImagePoster()
                    ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )

              ),
            ); 
          },
          itemCount: peliculas.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
  }
}