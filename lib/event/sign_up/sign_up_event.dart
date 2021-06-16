import 'package:interview_project/base/base_event.dart';

class SignUpEvent extends BaseEvent {
  SignUpEvent({
    required this.userName,
    required this.password,
  });

  String userName;
  String password;
}
