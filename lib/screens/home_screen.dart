import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model/character_model.dart';
import 'package:movies_showcase/services/bloc.dart';
import 'package:movies_showcase/services/network_client.dart';
import 'package:movies_showcase/services/result.dart';
import 'package:movies_showcase/screens/details_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<CharacterModel> _characters;

  // @override
  // void initState() {
  //   super.initState();
  //   NetworkClient().getCharacters().then((result) {
  //     setState(() {
  //       _characters = result.data.results;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bloc.fetchCharacters();
    return Scaffold(
      key: mainKey,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/marvel_logo.jpg',
          width: 100.0,
          height: 38.0,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: bloc.characters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _characters = snapshot.data.data.results;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _characters.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  name: _characters[index].name,
                                  description: _characters[index].description,
                                  imagePath: _characters[index].thumbnail,
                                  marvelId: _characters[index].id,
                                )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: _characters[index].thumbnail,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black26,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                          Positioned(
                            top: 100.0,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                _characters[index].name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  (snapshot.error as ApiResponse<CharacterModel>).message,
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
