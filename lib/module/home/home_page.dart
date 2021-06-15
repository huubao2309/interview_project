import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_widget.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/repository/login_repository.dart';
import 'package:interview_project/data/service/login_service/login_service.dart';
import 'package:interview_project/event/base_event/expired_token_event.dart';
import 'package:interview_project/event/base_event/no_data_show_event.dart';
import 'package:interview_project/event/base_event/unknown_error_event.dart';
import 'package:interview_project/shared_code/widgets/base_widget/bloc_listener.dart';
import 'package:interview_project/shared_code/widgets/loading_widget/loading_task.dart';
import 'package:provider/provider.dart';

import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: LoginService(),
        ),
        ProxyProvider<LoginService, LoginRepository>(
          update: (context, loginService, previous) => LoginRepository(
            loginService: loginService,
          ),
        ),
      ],
      bloc: const [],
      child: HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) {
          return BlocListener<HomeBloc>(
            listener: handleEvent,
            child: Scaffold(
              body: LoadingTask(
                bloc: bloc,
                child: Container(),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> handleEvent(BaseEvent event) async {
    if (event is ExpiredTokenEvent) {
      Navigator.popUntil(context, ModalRoute.withName(Route_Named_NavigatePage));
      await Navigator.pushReplacementNamed(context, Route_Named_LoginPage);
      return;
    }
    if (event is NoDataShowEvent) {
      Navigator.popUntil(context, ModalRoute.withName(Route_Named_NavigatePage));
      return;
    }
    if (event is UnknownErrorEvent) {
      Navigator.popUntil(context, ModalRoute.withName(Route_Named_NavigatePage));
      return;
    }
    return;
  }
}
