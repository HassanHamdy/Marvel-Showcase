class RelatedDataModel {
  int id;
  String title;
  String thumbnail;

  RelatedDataModel({this.title, this.thumbnail});

  RelatedDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    thumbnail = json['thumbnail'] != null
        ? "${json['thumbnail']['path']}/portrait_fantastic.${json['thumbnail']['extension']}"
        : null;
  }

  RelatedDataModel.fromDB(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson(int characterId) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['characterId'] = characterId;
    return data;
  }
}
