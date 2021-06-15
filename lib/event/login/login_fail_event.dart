import 'package:interview_project/base/base_event.dart';

class LoginFailEvent extends BaseEvent {
  LoginFailEvent(this.errMessage);

  final String errMessage;
}
