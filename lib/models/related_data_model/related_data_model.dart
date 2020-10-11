import '../thumbnail.dart';

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
