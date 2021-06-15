import 'package:interview_project/base/base_event.dart';

class NoImageShowEvent extends BaseEvent {
  NoImageShowEvent({required this.message});

  final String message;
}
