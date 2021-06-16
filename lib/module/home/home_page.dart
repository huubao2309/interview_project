import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_widget.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/repository/demo_graphql_repository.dart';
import 'package:interview_project/data/service/demo_service/demo_graphql_service.dart';
import 'package:interview_project/event/base_event/expired_token_event.dart';
import 'package:interview_project/event/base_event/no_data_show_event.dart';
import 'package:interview_project/event/base_event/unknown_error_event.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:interview_project/shared_code/widgets/appbar_widget/app_bar_widget.dart';
import 'package:interview_project/shared_code/widgets/base_widget/bloc_listener.dart';
import 'package:interview_project/shared_code/widgets/loading_widget/loading_item.dart';
import 'package:interview_project/shared_code/widgets/loading_widget/loading_task.dart';
import 'package:provider/provider.dart';
import 'package:interview_project/data/graphql/query/demo_query_graphql.dart';

import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: DemoGraphQLService(),
        ),
        ProxyProvider<DemoGraphQLService, DemoGraphQLRepository>(
          update: (context, demoGraphQLService, previous) => DemoGraphQLRepository(
            demoGraphQLService: demoGraphQLService,
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
  List<GetActiveTodos$Query$TodosSelectColumn> totalListItems = <GetActiveTodos$Query$TodosSelectColumn>[];
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(demoGraphQLRepository: Provider.of(context)),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) {
          return BlocListener<HomeBloc>(
            listener: handleEvent,
            child: Scaffold(
              appBar: AppBarWidget(
                title: tr('Home'),
                isVisibleBackButton: false,
              ),
              body: LoadingTask(
                bloc: bloc,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: _listTodoWidget(bloc),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: _buildUserName(bloc),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listTodoWidget(HomeBloc bloc) {
    return StreamProvider<Object?>.value(
      initialData: null,
      value: bloc.listTodoStream,
      catchError: (context, err) {
        print('Error List');
        return Container();
      },
      child: Consumer<Object?>(
        builder: (context, data, child) {
          if (data == null) {
            return Center(
              child: LoadingItemWidget(),
            );
          }
          if (data is Widget) {
            return Container();
          }

          final items = data as List<GetActiveTodos$Query$TodosSelectColumn>;
          totalListItems.addAll(items);
          return Scrollbar(
            controller: _scrollController,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels == 0) {
                    print('At top ListView');
                  } else {
                    // At Bottom ListView
                    if (totalListItems.isNotEmpty &&
                        totalListItems.length >= bloc.offsetItem + bloc.stepLimitItem &&
                        !isLoadingMore) {
                      isLoadingMore = true;
                      bloc
                        ..loadListTodo(
                          limit: bloc.stepLimitItem,
                          offset: bloc.offsetItem + bloc.stepLimitItem,
                        )
                        ..offsetItem = bloc.offsetItem + bloc.stepLimitItem;
                      isLoadingMore = false;
                    }
                  }
                }
                return true;
              },
              child: ListView.builder(
                itemCount: totalListItems.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: _detailOrderTransaction(bloc, totalListItems[index], index),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _detailOrderTransaction(HomeBloc bloc, GetActiveTodos$Query$TodosSelectColumn item, int index) {
    return Card(
      color: const Color(0xFFfffbd5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Container(
        height: 80,
        width: sizeDevice.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    '${tr('id')}: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item.id.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.textPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Text(
                    '${tr('title')}: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.textPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserName(HomeBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.userNameStream,
      child: Consumer<String?>(
        builder: (context, username, child) {
          return Container(
            width: sizeDevice.width,
            height: 30,
            color: AppColor.primaryColor,
            child: Center(
              child: Text(
                username ?? tr('no_name'),
                style: TextStyle(
                  color: AppColor.textSecondColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
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
