import 'package:interview_project/base/base_event.dart';

class ChangePasswordSuccessEvent extends BaseEvent {
  ChangePasswordSuccessEvent({required this.message});

  final String message;
}
