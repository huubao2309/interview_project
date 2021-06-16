import 'package:interview_project/common/define_field.dart';

class ResponseSignUpModel {
  ResponseSignUpModel({
    this.id,
    this.message,
    this.type,
  });

  factory ResponseSignUpModel.fromJson(Map<String, dynamic> map) {
    return ResponseSignUpModel(
      id: map[ID_FIELD],
      message: map[MESSAGE_FIELD],
      type: map[TYPE_FIELD],
    );
  }

  final String? id;
  final String? message;
  final String? type;
}
