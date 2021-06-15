import 'package:interview_project/base/base_event.dart';

class UnknownErrorEvent extends BaseEvent {
  UnknownErrorEvent({required this.message});

  final String message;
}
