import 'package:yagot_app/models/base_response_model.dart';

class ResponseException implements Exception {
  final BaseResponseModel model ;
  final int statusCode ;

  ResponseException(this.model , this.statusCode);
}