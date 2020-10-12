import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model.dart';
import 'package:movies_showcase/models/related_data_model.dart';
import 'package:movies_showcase/models/related_data_types.dart';
import 'package:movies_showcase/services/db_provider.dart';
import 'package:movies_showcase/services/network_client.dart';

class Repository {
  NetworkClient apiProvider = NetworkClient();

  Future<ApiResponse<CharacterModel>> getCharacters() async {
    var characters = await DbProvider.db.fetchCharacters();
    if (characters != null) return characters;
    characters = await apiProvider.getCharacters();
    DbProvider.db.addCharacters(characters.data.results);
    return characters;
  }

  Future<ApiResponse<RelatedDataModel>> getComics(int characterId) async {
    var relatedData = await DbProvider.db
        .fetchRelatedData(characterId, RelatedDataTypes.COMICS);
    if (relatedData != null) return relatedData;
    relatedData = await apiProvider.getCharacterRelatedData(
        characterId, RelatedDataTypes.COMICS);
    DbProvider.db.addRelatedData(
        relatedData.data.results, characterId, RelatedDataTypes.COMICS);
    return relatedData;
  }

  Future<ApiResponse<RelatedDataModel>> getEvents(int characterId) async {
    var relatedData = await DbProvider.db
        .fetchRelatedData(characterId, RelatedDataTypes.EVENTS);
    if (relatedData != null) return relatedData;
    relatedData = await apiProvider.getCharacterRelatedData(
        characterId, RelatedDataTypes.EVENTS);
    DbProvider.db.addRelatedData(
        relatedData.data.results, characterId, RelatedDataTypes.EVENTS);
    return relatedData;
  }

  Future<ApiResponse<RelatedDataModel>> getSeries(int characterId) async {
    var relatedData = await DbProvider.db
        .fetchRelatedData(characterId, RelatedDataTypes.SERIES);
    if (relatedData != null) return relatedData;
    relatedData = await apiProvider.getCharacterRelatedData(
        characterId, RelatedDataTypes.SERIES);
    DbProvider.db.addRelatedData(
        relatedData.data.results, characterId, RelatedDataTypes.SERIES);
    return relatedData;
  }

  Future<ApiResponse<RelatedDataModel>> getStories(int characterId) async {
    var relatedData = await DbProvider.db
        .fetchRelatedData(characterId, RelatedDataTypes.STORIES);
    if (relatedData != null) return relatedData;
    relatedData = await apiProvider.getCharacterRelatedData(
        characterId, RelatedDataTypes.STORIES);
    DbProvider.db.addRelatedData(
        relatedData.data.results, characterId, RelatedDataTypes.STORIES);
    return relatedData;
  }
}
