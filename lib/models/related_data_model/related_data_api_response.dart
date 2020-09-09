import 'related_data_result_info.dart';

class RelatedDataApiResponse {
  int code;
  String status;
  RelatedDataResultInfo data;

  RelatedDataApiResponse({this.code, this.status, this.data});

  RelatedDataApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null
        ? new RelatedDataResultInfo.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
