
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/event/base_event/expired_token_event.dart';
import 'package:interview_project/event/base_event/no_data_show_event.dart';
import 'package:interview_project/event/base_event/unknown_error_event.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/dialog_manager/locator.dart';
import 'package:interview_project/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:interview_project/shared_code/utils/methods/common_method.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {

  HomeBloc();

  final DialogService _dialogService = locator<DialogService>();

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  Future<void> doShowDialog({required String description,  required BaseEvent event, String title = '', String typeDialog = ''}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title.isNotEmpty ? title : tr('Info'),
      description: description,
      typeDialog: typeDialog.isEmpty ? typeDialog : DIALOG_ONE_BUTTON,
    );

    if (dialogResult.confirmed) {
      // Check event
      handleEventDialog(event);
    } else {
      //print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent event) {
    switch (event.runtimeType) {
      case ExpiredTokenEvent:
        // clear Cache
        clearSPrefCache();
        processEventSink.add(ExpiredTokenEvent()); // Notify ExpiredToken
        break;
      case NoDataShowEvent:
        processEventSink.add(NoDataShowEvent());
        break;
      case UnknownErrorEvent:
        final e = event as UnknownErrorEvent;
        processEventSink.add(UnknownErrorEvent(message: e.message));
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
