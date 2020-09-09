import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_showcase/models/character_model/character_api_response.dart';
import 'package:movies_showcase/models/related_data_model/related_data_api_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/error_response.dart';
import 'result.dart';

final String _ts = "11",
    _apiKey = "f8d127d63cd8edb9c1033cc71ab185d8",
    _hashKey = "f474ff0da6c37349e80cea5388e76c52";

class NetworkClient {
  final String _baseUrl = "https://gateway.marvel.com/v1/public";
  final String _auth = "ts=$_ts&apikey=$_apiKey&hash=$_hashKey";

  Future<http.Response> _request(
      {@required RequestType requestType,
      @required String path,
      dynamic parameter,
      Map<String, String> authHeader}) async {

    //request header
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    if (authHeader != null) header.addAll(authHeader);

    print("$_baseUrl/$path?$_auth");

    switch (requestType) {
      case RequestType.GET:
        return await http.get("$_baseUrl/$path?$_auth", headers: header);
      case RequestType.POST:
        return await http.post("$_baseUrl/$path",
            headers: header, body: json.encode(parameter));
      case RequestType.DELETE:
        return await http.delete("$_baseUrl/$path", headers: header);
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }

  Future<Result> getCharacters() async {
    try {
      final response =
          await _request(requestType: RequestType.GET, path: "characters");

      if (response.statusCode == 200) {
        return Result<CharacterApiResponse>.success(
            CharacterApiResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result.error(
            ErrorResponse(message: (json.decode(response.body)["message"])));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(ErrorResponse(message: "Code error"));
    }
  }

  Future<Result> getComics(int characterId) async {
    try {
      final response = await _request(
          requestType: RequestType.GET, path: "characters/$characterId/comics");
      if (response.statusCode == 200) {
        return Result<RelatedDataApiResponse>.success(
            RelatedDataApiResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result.error(
            ErrorResponse(message: (json.decode(response.body)["message"])));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(ErrorResponse(message: "Code error"));
    }
  }

  Future<Result> getSeries(int characterId) async {
    try {
      final response = await _request(
          requestType: RequestType.GET, path: "characters/$characterId/series");
      if (response.statusCode == 200) {
        return Result<RelatedDataApiResponse>.success(
            RelatedDataApiResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result.error(
            ErrorResponse(message: (json.decode(response.body)["message"])));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(ErrorResponse(message: "Code error"));
    }
  }

  Future<Result> getStories(int characterId) async {
    try {
      final response = await _request(
          requestType: RequestType.GET,
          path: "characters/$characterId/stories");
      if (response.statusCode == 200) {
        return Result<RelatedDataApiResponse>.success(
            RelatedDataApiResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result.error(
            ErrorResponse(message: (json.decode(response.body)["message"])));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(ErrorResponse(message: "Code error"));
    }
  }

  Future<Result> getEvents(int characterId) async {
    try {
      final response = await _request(
          requestType: RequestType.GET, path: "characters/$characterId/events");
      if (response.statusCode == 200) {
        return Result<RelatedDataApiResponse>.success(
            RelatedDataApiResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result.error(
            ErrorResponse(message: (json.decode(response.body)["message"])));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(ErrorResponse(message: "Code error"));
    }
  }
}

enum RequestType { GET, POST, DELETE }
