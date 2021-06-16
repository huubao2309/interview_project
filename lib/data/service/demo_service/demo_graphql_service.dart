import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:interview_project/common/define_field.dart';
import 'package:interview_project/network/graphql_network_api.dart';
import 'package:interview_project/shared_code/utils/methods/common_method.dart';
import 'package:interview_project/data/graphql/query/demo_query_graphql.dart';

class DemoGraphQLService {
  Future<QueryResult> getListTodo({required int limit, required int offset}) {
    print('Request Demo GraphQl with API: URI: ');
    return GraphQLService.instance.value
        .query(
      QueryOptions(
          document: GetActiveTodosQuery(
            variables: GetActiveTodosArguments(),
          ).document,
          variables: {
            LIMIT_FIELD: limit,
            OFFSET_FIELD: offset,
          }),
    )
        .timeout(Duration(seconds: int.parse(TIME_OUT_SECOND)), onTimeout: () {
      throw createError('Timeout Error');
    });
  }
}
