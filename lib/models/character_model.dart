class CharacterModel {
  int id;
  String name;
  String description;
  String thumbnail;

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'] != null
        ? "${json['thumbnail']['path']}/landscape_incredible.${json['thumbnail']['extension']}"
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
