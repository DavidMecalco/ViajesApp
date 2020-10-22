import 'package:flutter/material.dart';

import 'package:peliculas_udemy/src/pages/home_page.dart';
import 'package:peliculas_udemy/src/pages/pelicua_datalle.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/':  (BuildContext context) => HomePage(),
        'datalle' : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}