import 'dart:async';

import 'package:interview_project/data/service/demo_service/demo_graphql_service.dart';
import 'package:interview_project/data/graphql/query/demo_query_graphql.dart';

class DemoGraphQLRepository {
  DemoGraphQLRepository({required DemoGraphQLService demoGraphQLService}) : _demoGraphQLService = demoGraphQLService;

  final DemoGraphQLService _demoGraphQLService;

  Future<List<GetActiveTodos$Query$TodosSelectColumn>> getList({required int limit, required int offset}) async {
    final c = Completer<List<GetActiveTodos$Query$TodosSelectColumn>>();
    try {
      final results = await _demoGraphQLService.getListTodo(limit: limit, offset: offset);
      if (!results.hasException) {
        final listTodo = GetActiveTodos$Query.fromJson(results.data!).todos;
        c.complete(listTodo);
      } else {
        print('Exception: ${results.exception}');
        c.completeError(results.exception!);
      }
    } catch (ex, stackTrace) {
      print(stackTrace.toString());
      c.completeError(ex.toString());
    }

    return c.future;
  }
}
