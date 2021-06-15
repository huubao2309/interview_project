import 'package:interview_project/base/base_event.dart';

class NoDataShowEvent extends BaseEvent {
  NoDataShowEvent({this.message = ''});

  final String message;
}
