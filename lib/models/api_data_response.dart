import 'file:///D:/marvel/marvel-showcase/lib/models/character_model.dart';
import 'file:///D:/marvel/marvel-showcase/lib/models/related_data_model.dart';

class ApiDataResponse<T> {
  int offset;
  int limit;
  int total;
  int count;
  List<dynamic> results;

  ApiDataResponse(
      {this.offset, this.limit, this.total, this.count, this.results});

  ApiDataResponse.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      if (T == CharacterModel) {
        results = new List<CharacterModel>();
        json['results'].forEach((v) {
          results.add(CharacterModel.fromJson(v));
        });
      } else if (T == RelatedDataModel) {
        results = new List<RelatedDataModel>();
        json['results'].forEach((v) {
          results.add(RelatedDataModel.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
