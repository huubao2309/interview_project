import 'package:interview_project/base/base_event.dart';

class ChangePasswordFailEvent extends BaseEvent {
  ChangePasswordFailEvent({required this.errMessage});

  final String errMessage;
}
