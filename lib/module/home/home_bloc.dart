import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/repository/demo_graphql_repository.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/event/base_event/expired_token_event.dart';
import 'package:interview_project/event/base_event/no_data_show_event.dart';
import 'package:interview_project/event/base_event/unknown_error_event.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/dialog_manager/locator.dart';
import 'package:interview_project/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/methods/common_method.dart';
import 'package:rxdart/rxdart.dart';
import 'package:interview_project/data/graphql/query/demo_query_graphql.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  HomeBloc({required DemoGraphQLRepository demoGraphQLRepository}) {
    _demoGraphQLRepository = demoGraphQLRepository;

    loadListTodo(limit: 10, offset: 0);
    _loadUserName();
  }

  final DialogService _dialogService = locator<DialogService>();

  late DemoGraphQLRepository _demoGraphQLRepository;

  final int stepLimitItem = 10;

  int offsetItem = 0;

  final _listTodoSubject = BehaviorSubject<List<GetActiveTodos$Query$TodosSelectColumn>>();

  Stream<List<GetActiveTodos$Query$TodosSelectColumn>> get listTodoStream => _listTodoSubject.stream;

  Sink<List<GetActiveTodos$Query$TodosSelectColumn>> get listTodoSink => _listTodoSubject.sink;

  final _userNameSubject = BehaviorSubject<String?>();

  Stream<String?> get userNameStream => _userNameSubject.stream;

  Sink<String?> get userNameSink => _userNameSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  Future<void> loadListTodo({required int limit, required int offset}) async {
    await _demoGraphQLRepository.getList(limit: limit, offset: offset).then(
      (result) async {
        if (result.isNotEmpty) {
          listTodoSink.add(result);
        } else {
          await doShowDialog(
            description: tr('unknown_error'),
            event: UnknownErrorEvent(message: tr('unknown_error')),
            typeDialog: ERROR_DIALOG,
          );
        }
        loadingSink.add(false); // hide loading
      },
      onError: (e) {
        loadingSink.add(false); // hide loading
        print(e);
        if (e == Unauthorized_Error_Code || e == ErrorExpiredTokenCode) {
          doShowDialog(
            description: tr('expired_token'),
            event: ExpiredTokenEvent(),
            typeDialog: ERROR_DIALOG,
          );
        } else {
          doShowDialog(
            description: tr('unknown_error'),
            event: UnknownErrorEvent(message: tr('unknown_error')),
            typeDialog: ERROR_DIALOG,
          );
        }
      },
    );
  }

  Future<void> _loadUserName() async {
    final username = await SPref.instance.get(SPrefCache.USER_NAME);
    userNameSink.add(username);
  }

  Future<void> doShowDialog(
      {required String description, required BaseEvent event, String title = '', String typeDialog = ''}) async {
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
    _listTodoSubject.close();
    _userNameSubject.close();
  }
}
