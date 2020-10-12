import 'dart:async';

import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model.dart';
import 'package:movies_showcase/models/related_data_model.dart';

class Validators {
  final characterResponseSuccess = StreamTransformer<
      ApiResponse<CharacterModel>, ApiResponse<CharacterModel>>.fromHandlers(
    handleData: (data, sink) {
      if (data.code is int && data.code == 200)
        sink.add(data);
      else
        sink.addError(data);
    },
  );

  final relatedDataResponseSuccess = StreamTransformer<
      ApiResponse<RelatedDataModel>,
      ApiResponse<RelatedDataModel>>.fromHandlers(
    handleData: (data, sink) {
      if (data.code is int && data.code == 200)
        sink.add(data);
      else
        sink.addError(data);
    },
  );
}
