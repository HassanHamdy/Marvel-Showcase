import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model/character_model.dart';
import 'package:movies_showcase/models/related_data_model/related_data_model.dart';
import 'package:movies_showcase/services/network_client.dart';

class Repository {
  NetworkClient apiProvider = NetworkClient();

  Future<ApiResponse<CharacterModel>> getCharacters() {
    return apiProvider.getCharacters();
  }

  Future<ApiResponse<RelatedDataModel>> getComics(int characterId) {
    return apiProvider.getCharacterRelatedData(characterId, "comics");
  }

  Future<ApiResponse<RelatedDataModel>> getEvents(int characterId) {
    return apiProvider.getCharacterRelatedData(characterId, "events");
  }

  Future<ApiResponse<RelatedDataModel>> getSeries(int characterId) {
    return apiProvider.getCharacterRelatedData(characterId, "series");
  }

  Future<ApiResponse<RelatedDataModel>> getStories(int characterId) {
    return apiProvider.getCharacterRelatedData(characterId, "stories");
  }
}
