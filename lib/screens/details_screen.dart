import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_showcase/models/related_data_model/related_data_api_response.dart';
import 'package:movies_showcase/models/related_data_model/related_data_result.dart';
import 'package:movies_showcase/networking/network_client.dart';
import 'package:movies_showcase/networking/result.dart';

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
  List<RelatedDataResult> _comics, _events, _series, _stories;

  @override
  void initState() {
    NetworkClient().getComics(widget.marvelId).then((result) {
      if (result is SuccessState) {
        setState(() {
          _comics = result.value.data.results;
        });
      }
      else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getEvents(widget.marvelId).then((result) {
      if (result is SuccessState) {
        setState(() {
          _events = result.value.data.results;
        });
      }
      else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getSeries(widget.marvelId).then((result) {
      if (result is SuccessState) {
        setState(() {
          _series = result.value.data.results;
        });
      }
      else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });

    NetworkClient().getStories(widget.marvelId).then((result) {
      if (result is SuccessState) {
        setState(() {
          _stories = result.value.data.results;
        });
      }
      else {
        mainKey.currentState.showSnackBar(SnackBar(
          content: Text(
            (result as ErrorState).msg,
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      body: ListView(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                height: 200,
                imageUrl: widget.imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
              Container(
                color: Colors.black26,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
          DetailsHeader(name: "NAME",),
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
          DetailsHeader(name: 'COMICS',),
          _comics != null ? RelatedDataWidget(relatedDataList: _comics) :
          Container(
            height: 100.0,
            child: Center(child: CircularProgressIndicator()),
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(name: 'SERIES',),
          _series != null ? RelatedDataWidget(relatedDataList: _series) :
          Container(
            height: 100.0,
            child: Center(child: CircularProgressIndicator()),
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(name: 'STORIES'),
          _stories != null ? RelatedDataWidget(relatedDataList: _stories) :
          Container(
            height: 100.0,
            child: Center(child: CircularProgressIndicator()),
          ),
          SizedBox(
            height: 16.0,
          ),
          DetailsHeader(name: 'EVENTS'),
          _events != null ? RelatedDataWidget(relatedDataList: _events) :
          Container(
            height: 100.0,
            child: Center(child: CircularProgressIndicator()),
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
    @required List<RelatedDataResult> relatedDataList,
  }) : _relatedDataList = relatedDataList, super(key: key);

  final List<RelatedDataResult> _relatedDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: _relatedDataList.isNotEmpty?Card(
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
                    imageUrl: _relatedDataList[index].thumbnail != null?"${_relatedDataList[index].thumbnail
                        .path}/portrait_fantastic.${_relatedDataList[index].thumbnail
                        .extension}":"",
                    progressIndicatorBuilder: (context, url,
                        downloadProgress) =>
                        Center(
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
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          },),
      ):Center(
          child: Text(
            'No Data Available',
            style: TextStyle(fontSize: 16.0),
          )),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  final String name;

  const DetailsHeader({
    Key key,
    @required this.name
  }) : super(key: key);

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
