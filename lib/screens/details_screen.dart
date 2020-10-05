import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_showcase/models/character_model/character_result.dart';
import 'package:movies_showcase/models/related_data_model/related_data_result.dart';
import 'package:movies_showcase/networking/network_client.dart';
import 'package:movies_showcase/networking/result.dart';
import 'package:movies_showcase/scoped_models/marvel_model.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsScreen extends StatefulWidget {
  final MarvelModel model;

  const DetailsScreen({Key key, @required this.model}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<RelatedDataResult> _comics, _events, _series, _stories;
  CharacterResult _character;

  @override
  void initState() {
    _character = widget.model.getSingleCharacter();
    NetworkClient().getComics(_character.id).then((result) {
      if (result is SuccessState) {
        widget.model.setComics(result.value.data.results);
        // setState(() {
        //   _comics = result.value.data.results;
        // });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getEvents(_character.id).then((result) {
      if (result is SuccessState) {
        widget.model.setEvents(result.value.data.results);
        // setState(() {
        //   _events = result.value.data.results;
        // });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getSeries(_character.id).then((result) {
      if (result is SuccessState) {
        widget.model.setSeries(result.value.data.results);
        // setState(() {
        //   _series = result.value.data.results;
        // });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getStories(_character.id).then((result) {
      if (result is SuccessState) {
        widget.model.setStories(result.value.data.results);
        // setState(() {
        //   _stories = result.value.data.results;
        // });
      } else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg.message,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MarvelModel>(
      builder: (context, child, model) {
        _comics = model.getComics();
        _events = model.getEvents();
        _series = model.getSeries();
        _stories = model.getStories();
        return Scaffold(
          key: mainKey,
          body: ListView(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "${_character.thumbnail.path}/landscape_incredible.${_character.thumbnail.extension}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                  Container(
                    color: Colors.black26,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    ),
                  )
                ],
              ),
              DetailsHeader(
                name: "NAME",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _character.name,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Visibility(
                visible: _character.description.isNotEmpty,
                child: DetailsHeader(name: 'DESCRIPTION'),
              ),
              Visibility(
                visible: _character.description.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _character.description,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              DetailsHeader(
                name: 'COMICS',
              ),
              _comics != null
                  ? RelatedDataWidget(relatedDataList: _comics)
                  : Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
              SizedBox(
                height: 16.0,
              ),
              DetailsHeader(
                name: 'SERIES',
              ),
              _series != null
                  ? RelatedDataWidget(relatedDataList: _series)
                  : Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
              SizedBox(
                height: 16.0,
              ),
              DetailsHeader(name: 'STORIES'),
              _stories != null
                  ? RelatedDataWidget(relatedDataList: _stories)
                  : Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
              SizedBox(
                height: 16.0,
              ),
              DetailsHeader(name: 'EVENTS'),
              _events != null
                  ? RelatedDataWidget(relatedDataList: _events)
                  : Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class RelatedDataWidget extends StatelessWidget {
  const RelatedDataWidget({
    Key key,
    @required List<RelatedDataResult> relatedDataList,
  })  : _relatedDataList = relatedDataList,
        super(key: key);

  final List<RelatedDataResult> _relatedDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: _relatedDataList.isNotEmpty
          ? Card(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _relatedDataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: _relatedDataList[index].thumbnail != null
                              ? "${_relatedDataList[index].thumbnail.path}/portrait_fantastic.${_relatedDataList[index].thumbnail.extension}"
                              : "",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _relatedDataList[index].title,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text(
              'No Data Available',
              style: TextStyle(fontSize: 16.0),
            )),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  final String name;

  const DetailsHeader({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: TextStyle(fontSize: 16.0, color: Colors.red),
      ),
    );
  }
}
