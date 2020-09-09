import '../thumbnail.dart';

class RelatedDataResult {
  String title;
  Thumbnail thumbnail;

  RelatedDataResult({this.title, this.thumbnail});

  RelatedDataResult.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    return data;
  }
}
