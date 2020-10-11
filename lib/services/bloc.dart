import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model/character_model.dart';
import 'package:movies_showcase/models/related_data_model/related_data_model.dart';
import 'package:movies_showcase/services/validators.dart';
import 'package:rxdart/rxdart.dart';

import 'repository.dart';

class Bloc extends Validators {
  Repository _repository = Repository();

  final _charactersFetcher = BehaviorSubject<ApiResponse<CharacterModel>>();
  final _comicsFetcher = BehaviorSubject<ApiResponse<RelatedDataModel>>();
  final _eventsFetcher = BehaviorSubject<ApiResponse<RelatedDataModel>>();
  final _seriesFetcher = BehaviorSubject<ApiResponse<RelatedDataModel>>();
  final _storiesFetcher = BehaviorSubject<ApiResponse<RelatedDataModel>>();

  Stream<ApiResponse<CharacterModel>> get characters =>
      _charactersFetcher.stream.transform(characterResponseSuccess);

  Stream<ApiResponse<RelatedDataModel>> get comics =>
      _comicsFetcher.stream.transform(relatedDataResponseSuccess);

  Stream<ApiResponse<RelatedDataModel>> get events =>
      _eventsFetcher.stream.transform(relatedDataResponseSuccess);

  Stream<ApiResponse<RelatedDataModel>> get series =>
      _seriesFetcher.stream.transform(relatedDataResponseSuccess);

  Stream<ApiResponse<RelatedDataModel>> get stories =>
      _storiesFetcher.stream.transform(relatedDataResponseSuccess);

  fetchCharacters() async {
    final characterResponse = await _repository.getCharacters();
    _charactersFetcher.sink.add(characterResponse);
  }

  fetchComics(int characterId) async {
    final relatedDataResponse = await _repository.getComics(characterId);
    _comicsFetcher.sink.add(relatedDataResponse);
  }

  fetchEvents(int characterId) async {
    final relatedDataResponse = await _repository.getEvents(characterId);
    _eventsFetcher.sink.add(relatedDataResponse);
  }

  fetchSeries(int characterId) async {
    final relatedDataResponse = await _repository.getSeries(characterId);
    _seriesFetcher.sink.add(relatedDataResponse);
  }

  fetchStories(int characterId) async {
    final relatedDataResponse = await _repository.getStories(characterId);
    _storiesFetcher.sink.add(relatedDataResponse);
  }

  dispose() {
    _charactersFetcher.close();
    _comicsFetcher.close();
    _eventsFetcher.close();
    _storiesFetcher.close();
    _seriesFetcher.close();
  }
}

final Bloc bloc = Bloc();
