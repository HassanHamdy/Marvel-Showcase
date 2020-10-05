import 'package:movies_showcase/models/character_model/character_result.dart';
import 'package:movies_showcase/models/related_data_model/related_data_result.dart';
import 'package:scoped_model/scoped_model.dart';

class MarvelModel extends Model {
  List<CharacterResult> _characters;
  List<RelatedDataResult> _comics, _events, _series, _stories;
  int _selectedIndex;

  List<CharacterResult> getCharacters() {
    return _characters;
  }

  List<RelatedDataResult> getComics() {
    return _comics;
  }

  List<RelatedDataResult> getEvents() {
    return _events;
  }

  List<RelatedDataResult> getSeries() {
    return _series;
  }

  List<RelatedDataResult> getStories() {
    return _stories;
  }

  int getIndex() {
    return _selectedIndex;
  }

  setIndex(int i) {
    _selectedIndex = i;
  }

  CharacterResult getSingleCharacter() {
    return _characters[_selectedIndex];
  }

  void setCharacters(List<CharacterResult> characters) {
    _characters = List.from(characters);
    notifyListeners();
  }

  void setComics(List<RelatedDataResult> comics) {
    _comics = comics;
    notifyListeners();
  }

  void setEvents(List<RelatedDataResult> events) {
    _events = events;
    notifyListeners();
  }

  void setSeries(List<RelatedDataResult> series) {
    _series = series;
    notifyListeners();
  }

  void setStories(List<RelatedDataResult> stories) {
    _stories = stories;
    notifyListeners();
  }
}
