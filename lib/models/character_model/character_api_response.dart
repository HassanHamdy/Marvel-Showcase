import 'character_result_info.dart';

class CharacterApiResponse {
  int code;
  String status;
  CharacterResultInfo data;

  CharacterApiResponse({this.code, this.status, this.data});

  CharacterApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null
        ? new CharacterResultInfo.fromJson(json['data'])
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
