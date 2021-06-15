import 'package:interview_project/base/base_event.dart';

class ChangePasswordEvent extends BaseEvent {
  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;
}
