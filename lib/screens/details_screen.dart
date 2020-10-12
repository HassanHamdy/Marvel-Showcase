import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_showcase/models/api_response.dart';
import 'file:///D:/marvel/marvel-showcase/lib/models/related_data_model.dart';
import 'package:movies_showcase/services/bloc.dart';

class DetailsScreen extends StatefulWidget {
  final int marvelId;
  final String name, description, imagePath;

  const DetailsScreen(
      {Key key, this.marvelId, this.name, this.description, this.imagePath})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final mainKey = GlobalKey<ScaffoldState>();
  List<RelatedDataModel> _comics, _events, _series, _stories;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchComics(widget.marvelId);
    bloc.fetchEvents(widget.marvelId);
    bloc.fetchSeries(widget.marvelId);
    bloc.fetchStories(widget.marvelId);
    return Scaffold(
      key: mainKey,
      body: ListView(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                height: 200,
                width: MediaQuery.of(context).size.width,
                imageUrl: widget.imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
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
              widget.name,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Visibility(
            visible: widget.description.isNotEmpty,
            child: DetailsHeader(name: 'DESCRIPTION'),
          ),
          Visibility(
            visible: widget.description.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description,
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
          StreamBuilder(
            stream: bloc.comics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _comics = snapshot.data.data.results;
                return RelatedDataWidget(relatedDataList: _comics);
              } else if (snapshot.hasError) {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: Text(
                      (snapshot.error as ApiResponse<RelatedDataModel>).message,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }

              return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(
            name: 'SERIES',
          ),
          StreamBuilder(
            stream: bloc.series,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _series = snapshot.data.data.results;
                return RelatedDataWidget(relatedDataList: _series);
              } else if (snapshot.hasError) {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: Text(
                      (snapshot.error as ApiResponse<RelatedDataModel>).message,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }

              return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(name: 'STORIES'),
          StreamBuilder(
            stream: bloc.stories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _stories = snapshot.data.data.results;
                return RelatedDataWidget(relatedDataList: _stories);
              } else if (snapshot.hasError) {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: Text(
                      (snapshot.error as ApiResponse<RelatedDataModel>).message,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }

              return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(name: 'EVENTS'),
          StreamBuilder(
            stream: bloc.events,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _events = snapshot.data.data.results;
                return RelatedDataWidget(relatedDataList: _events);
              } else if (snapshot.hasError) {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: Text(
                      (snapshot.error as ApiResponse<RelatedDataModel>).message,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }

              return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}

class RelatedDataWidget extends StatelessWidget {
  const RelatedDataWidget({
    Key key,
    @required List<RelatedDataModel> relatedDataList,
  })  : _relatedDataList = relatedDataList,
        super(key: key);

  final List<RelatedDataModel> _relatedDataList;

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
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 16.0, bottom: 8.0),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: _relatedDataList[index].thumbnail != null
                              ? _relatedDataList[index].thumbnail
                              : "",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 4.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                _relatedDataList[index].title,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
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
