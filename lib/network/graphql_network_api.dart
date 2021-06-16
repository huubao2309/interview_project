import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:interview_project/common/define_field.dart';
import 'package:interview_project/common/define_service_api.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';

class GraphQLService {
  GraphQLService._internal();

  static String _token = '';

  static final HttpLink httpLink = HttpLink(graphQLServiceUrl);

  static final AuthLink authLink = AuthLink(getToken: () async {
    _token = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);
    if (_token.toString().isNotEmpty) {
      return 'Bearer $_token';
    }
    return _token;
  });

  static Map<String, dynamic> getHeaderAuthorizationMap() {
    return <String, dynamic>{
      'headers': {AUTHORIZATION_FIELD: 'Bearer $_token'},
    };
  }

  static final WebSocketLink webSocketLink = WebSocketLink(
    webSocketGraphQLUrl,
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: getHeaderAuthorizationMap,
    ),
  );

  static final Link link = authLink.concat(httpLink).concat(webSocketLink);

  static final ValueNotifier<GraphQLClient> _graphQL = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );

  static final instance = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
      defaultPolicies: DefaultPolicies(
        watchQuery: Policies(
          fetch: FetchPolicy.noCache,
        ),
        query: Policies(
          fetch: FetchPolicy.noCache,
        ),
        mutate: Policies(
          fetch: FetchPolicy.noCache,
        ),
      ),
    ),
  );

  ValueNotifier<GraphQLClient> get graphQL => _graphQL;
}
