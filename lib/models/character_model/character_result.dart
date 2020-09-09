import '../thumbnail.dart';
import 'character_related_data.dart';

class CharacterResult {
  int id;
  String name;
  String description;
  Thumbnail thumbnail;
  CharacterRelatedData comics;
  CharacterRelatedData series;
  CharacterRelatedData stories;
  CharacterRelatedData events;

  CharacterResult(
      {this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.comics,
      this.series,
      this.stories,
      this.events});

  CharacterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    comics = json['comics'] != null
        ? new CharacterRelatedData.fromJson(json['comics'])
        : null;
    series = json['series'] != null
        ? new CharacterRelatedData.fromJson(json['series'])
        : null;
    stories = json['stories'] != null
        ? new CharacterRelatedData.fromJson(json['stories'])
        : null;
    events = json['events'] != null
        ? new CharacterRelatedData.fromJson(json['events'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.comics != null) {
      data['comics'] = this.comics.toJson();
    }
    if (this.series != null) {
      data['series'] = this.series.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events.toJson();
    }
    return data;
  }
}
