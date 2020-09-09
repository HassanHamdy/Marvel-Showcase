import 'related_data_result.dart';

class RelatedDataResultInfo {
  int offset;
  int limit;
  int total;
  int count;
  List<RelatedDataResult> results;

  RelatedDataResultInfo(
      {this.offset, this.limit, this.total, this.count, this.results});

  RelatedDataResultInfo.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = new List<RelatedDataResult>();
      json['results'].forEach((v) {
        results.add(RelatedDataResult.fromJson(v));
      });
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
