import 'package:interview_project/base/base_event.dart';

class SignUpFailEvent extends BaseEvent {
  SignUpFailEvent(this.errMessage);

  final String errMessage;
}
