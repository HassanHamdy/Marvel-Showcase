import 'package:flutter/material.dart';
import 'package:movies_showcase/models/character_model/character_result.dart';
import 'package:movies_showcase/scoped_models/marvel_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MarvelModel model = MarvelModel();
    return ScopedModel(
      model: model,
      child: MaterialApp(
        title: 'Marvel Showcase',
        theme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Marvel Showcase', model: model),
      ),
    );
  }
}
