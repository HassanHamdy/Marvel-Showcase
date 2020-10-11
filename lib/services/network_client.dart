import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model/character_model.dart';
import 'package:movies_showcase/models/related_data_model/related_data_model.dart';

import '../models/error_response.dart';
import 'result.dart';

final String _ts = "11",
    _apiKey = "f8d127d63cd8edb9c1033cc71ab185d8",
    _hashKey = "f474ff0da6c37349e80cea5388e76c52";

class NetworkClient {
  final String _baseUrl = "https://gateway.marvel.com/v1/public";
  final String _auth = "ts=$_ts&apikey=$_apiKey&hash=$_hashKey";
  final client = Client();

  Future<dynamic> _request(
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
        return await client.get("$_baseUrl/$path?$_auth", headers: header);
      case RequestType.POST:
        return await client.post("$_baseUrl/$path",
            headers: header, body: json.encode(parameter));
      case RequestType.DELETE:
        return await client.delete("$_baseUrl/$path", headers: header);
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }

  Future<ApiResponse<CharacterModel>> getCharacters() async {
    try {
      final response =
          await _request(requestType: RequestType.GET, path: "characters");

      return ApiResponse<CharacterModel>.fromJson(json.decode(response.body));
    } catch (error) {
      print("ERROR $error");
      throw Exception('Error in Parsing');
    }
  }

  Future<ApiResponse<RelatedDataModel>> getCharacterRelatedData(
      int characterId, String type) async {
    try {
      final response = await _request(
          requestType: RequestType.GET, path: "characters/$characterId/$type");
      return ApiResponse<RelatedDataModel>.fromJson(json.decode(response.body));
    } catch (error) {
      print("ERROR $error");
      throw Exception('Error in Parsing');
    }
  }
}

enum RequestType { GET, POST, DELETE }
