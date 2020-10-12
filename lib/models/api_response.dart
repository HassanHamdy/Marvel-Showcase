import 'package:movies_showcase/models/api_data_response.dart';

class ApiResponse<T> {
  dynamic code;
  String status;
  String message;
  ApiDataResponse<T> data;

  ApiResponse({this.code, this.status, this.data, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    print(T.runtimeType);
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new ApiDataResponse<T>.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
