import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/dialog_request.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/dialog_response.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:interview_project/shared_code/widgets/dialog_widget/congratulate_dialog.dart';
import 'package:interview_project/shared_code/widgets/dialog_widget/dialog_one_button.dart';
import 'package:interview_project/shared_code/widgets/dialog_widget/dialog_two_button.dart';
import 'package:interview_project/shared_code/widgets/dialog_widget/error_dialog.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  const DialogManager({required this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.showDialogListener = _showDialog;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }

  Future<void> _showDialog(DialogRequest request) async {
    await showDialog(
      context: context,
      barrierDismissible: request.isMustTapButton, // user must tap button!
      builder: (context) {
        return _chooseTypeDialog(request);
      },
    );
  }

  Widget _chooseTypeDialog(DialogRequest request) {
    switch (request.typeDialog) {
      case DIALOG_ONE_BUTTON:
        return _dialogOneButton(request);

      case DIALOG_ONE_BUTTON_WITH_OPACITY:
        return _dialogOneButtonWithOpacity(request);

      case DIALOG_TWO_BUTTON:
        return _dialogTwoButton(request);

      case DIALOG_CONGRATULATE_BUTTON:
        return _dialogCongratulateButton(request);

      case ERROR_DIALOG:
        return _dialogError(request);

      default:
        return _dialogOneButton(request);
    }
  }

  Widget _dialogOneButton(DialogRequest request) {
    return DialogOneButton(
      title: request.title,
      content: request.description,
      textButton: request.titleButton ,
      onPressed: () async {
        _dialogService.dialogComplete(DialogResponse(confirmed: true));
        // Hide popup
        Navigator.of(context).pop('dialog');
      },
    );
  }

  Widget _dialogError(DialogRequest request) {
    return ErrorDialog(
      title: request.title,
      content: request.description,
      textButton: request.titleButton,
      onPressed: () async {
        _dialogService.dialogComplete(DialogResponse(confirmed: true));
        // Hide popup
        Navigator.of(context).pop('dialog');
      },
    );
  }

  Widget _dialogOneButtonWithOpacity(DialogRequest request) {
    return Container(
      width: sizeDevice.width,
      height: sizeDevice.height,
      color: AppColor.primaryBackgroundColor.withOpacity(0.6),
      child: DialogOneButton(
        title: request.title,
        content: request.description,
        onPressed: () async {
          _dialogService.dialogComplete(DialogResponse(confirmed: true));
          // Hide popup
          Navigator.of(context).pop('dialog');
        },
      ),
    );
  }

  Widget _dialogTwoButton(DialogRequest request) {
    return DialogTwoButton(
      title: request.title,
      content: request.description,
      onPressedAgree: () {
        _dialogService.dialogComplete(DialogResponse(confirmed: true));
        Navigator.of(context).pop('dialog');
      },
      onPressedCancel: () {
        _dialogService.dialogComplete(DialogResponse(confirmed: false));
        Navigator.of(context).pop('dialog');
      },
    );
  }

  Widget _dialogCongratulateButton(DialogRequest request) {
    return CongratulateDialog(
      content: request.description,
      textButton: request.titleButton,
      onPressed: () async {
        _dialogService.dialogComplete(DialogResponse(confirmed: true));
        // Hide popup
        Navigator.of(context).pop('dialog');
      },
    );
  }
}
