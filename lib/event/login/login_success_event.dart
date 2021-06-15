import 'package:interview_project/base/base_event.dart';

class LoginSuccessEvent extends BaseEvent {
  LoginSuccessEvent({required this.token});

  final String token;
}
